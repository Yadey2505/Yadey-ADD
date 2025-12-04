param(
    [string]$accion,
    [string]$param2,
    [string]$param3,
    [string]$param4,
    [bool]$dryrun = $false
)

# Sin accion
if (-not $accion) {
    Write-Host "Debes indicar una acción."
    Write-Host "Acciones: -G, -U, -M, -AG, -LIST"
    exit
}

# Crear grupo
if ($accion -eq "-G") {
    $ambito = $param2
    $tipo = $param3
    $nombre = $param4

    if ($dryrun) {
        Write-Host "[DRYRUN] Se crearía el grupo $nombre ($ambito / $tipo)"
        exit
    }

    if (Get-ADGroup -Filter "Name -eq '$nombre'") {
        Write-Host "El grupo $nombre ya existe."
    }
    else {
        New-ADGroup -Name $nombre -GroupScope $ambito -GroupCategory $tipo
        Write-Host "Grupo $nombre creado."
    }
}

# Crear usuario
if ($accion -eq "-U") {
    $usuario = $param2
    $ou = $param3
    $pwd = $param4

    if ($dryrun) {
        Write-Host "[DRYRUN] Se crearía el usuario $usuario en $ou con contraseña."
        exit
    }

    if (Get-ADUser -Filter "SamAccountName -eq '$usuario'") {
        Write-Host "El usuario $usuario ya existe."
    }
    else {
        New-ADUser -Name $usuario -SamAccountName $usuario -AccountPassword (ConvertTo-SecureString $pwd -AsPlainText -Force) -Enabled $true -Path $ou
        Write-Host "Usuario $usuario creado."
    }
}

# Modificar usuario
if ($accion -eq "-M") {
    $pwd = $param2
    $accionCuenta = $param3
    $usuario = $param4

    if ($dryrun) {
        Write-Host "[DRYRUN] Se cambiaría la contraseña de $usuario y acción: $accionCuenta"
        exit
    }

    Set-ADAccountPassword -Identity $usuario -NewPassword (ConvertTo-SecureString $pwd -AsPlainText -Force) -Reset
    Write-Host "Contraseña cambiada."

    if ($accionCuenta -eq "enable") {
        Enable-ADAccount -Identity $usuario
        Write-Host "Cuenta habilitada."
    }
    else {
        Disable-ADAccount -Identity $usuario
        Write-Host "Cuenta deshabilitada."
    }
}

# Asignar grupo
if ($accion -eq "-AG") {

    if ($dryrun) {
        Write-Host "[DRYRUN] Se añadiría el usuario $param2 al grupo $param3"
        exit
    }

    Add-ADGroupMember -Identity $param3 -Members $param2
    Write-Host "Usuario añadido al grupo."
}

# Listar objetos
if ($accion -eq "-LIST") {

    if ($dryrun) {
        Write-Host "[DRYRUN] Se listarían objetos tipo $param2"
        exit
    }

    if ($param2 -eq "Usuarios") {
        Get-ADUser -Filter * | Select Name,SamAccountName,Enabled
    }

    if ($param2 -eq "Grupos") {
        Get-ADGroup -Filter * | Select Name,GroupScope,GroupCategory
    }

    if ($param2 -eq "Ambos") {
        Write-Host "Usuarios:"
        Get-ADUser -Filter * | Select Name,SamAccountName,Enabled

        Write-Host "Grupos:"
        Get-ADGroup -Filter * | Select Name,GroupScope,GroupCategory
    }
}