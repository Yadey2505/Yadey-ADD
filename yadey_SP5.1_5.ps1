Import-Module ActiveDirectory

# Espera a que el usuario pulse ENTER antes de volver al menú
function Pausa { Read-Host "`nPulsa ENTER para continuar" | Out-Null }

# Devuelve el DN de una OU 
function Get-OUDN ($nombre, $usersDefault = $false) {
    if (-not $nombre) {
        $base = (Get-ADDomain).DistinguishedName
        if ($usersDefault) { return "CN=Users,$base" } else { return $base }
    }
    return (Get-ADOrganizationalUnit -Filter "Name -eq '$nombre'").DistinguishedName
}

# Mostrar Informacion del Dominio
function Info-Dominio {
    Write-Host "=== Informacion del Dominio ==="
    $dominio = Get-ADDomain
    Write-Host "Equipo  : $env:COMPUTERNAME"
    Write-Host "Dominio : $($dominio.DNSRoot)"
    Write-Host "OUs     : $((Get-ADOrganizationalUnit -Filter *).Count)"
    Write-Host "Grupos  : $((Get-ADGroup -Filter *).Count)"
    Write-Host "Usuarios: $((Get-ADUser -Filter *).Count)"
    Pausa
}

# Crea una OU.
function Crear-OU {
    $nombre = Read-Host "Nombre de la OU"
    $path   = Get-OUDN (Read-Host "OU padre (vacio = raiz)") $false
    if (-not $path) { Pausa; return }
    try {
        New-ADOrganizationalUnit -Name $nombre -Path $path
        Write-Host "OU '$nombre' creada."
    } catch {
        Write-Host "ERROR: $_" 
    }
    Pausa
}

# Listar los objetos de la OU
function Ver-OU {
    $dominion = Get-OUDN (Read-Host "Nombre de la OU")
    Get-ADObject -Filter * -SearchBase $dominion -SearchScope OneLevel |
        Select-Object ObjectClass, Name | Format-Table -AutoSize
    Pausa
}

# Crea un grupo en la OU. 
function Crear-Grupo {
    $nombre = Read-Host "Nombre del grupo"
    $ambito = Read-Host "Ambito (Global/Universal/DomainLocal)"
    $tipo   = Read-Host "Categoria (Security/Distribution)"
    $path   = Get-OUDN (Read-Host "OU (vacio = CN=Users)") $true
    if (-not $path) { Pausa; return }
    try {
        New-ADGroup -Name $nombre -GroupScope $ambito -GroupCategory $tipo -Path $path
        Write-Host "Grupo '$nombre' creado."
    } catch {
        Write-Host "ERROR: $_"
    }
    Pausa
}

# Crea un usuario.
function Crear-Usuario {
    $user  = Read-Host "Nombre de usuario"
    $contra = Read-Host "Contraseña" -AsSecureString
    $path  = Get-OUDN (Read-Host "OU (vacio = CN=Users)") $true
    $grupo = Read-Host "Grupo (vacio = ninguno)"
    if (-not $path) { Pausa; return }
    try {
        New-ADUser -Name $user -SamAccountName $user `
            -UserPrincipalName "$user@$((Get-ADDomain).DNSRoot)" `
            -Path $path -AccountPassword $contra `
            -Enabled $true -ChangePasswordAtLogon $true
        # Añadir a grupo
        if ($grupo) { Add-ADGroupMember -Identity $grupo -Members $user }
        Write-Host "Usuario '$user' creado."
    } catch {
        Write-Host "ERROR: $_"
    }
    Pausa
}

# Bucle principal
do {
    Clear-Host
    Write-Host "=== MENU Yadey ==="
    Write-Host "1. Informacion del dominio"
    Write-Host "2. Crear OU"
    Write-Host "3. Ver miembros de una OU"
    Write-Host "4. Crear grupo"
    Write-Host "5. Crear usuario"
    Write-Host "0. Salir"
    $op = Read-Host "Opcion"
    switch ($op) {
        "1" { Info-Dominio  }
        "2" { Crear-OU      }
        "3" { Ver-OU        }
        "4" { Crear-Grupo   }
        "5" { Crear-Usuario }
        "0" { Write-Host "Adios." }
        default { Write-Host "Opcion no valida." }
    }
} while ($op -ne "0")