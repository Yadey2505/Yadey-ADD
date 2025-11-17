# Obtener todos los tipos de registros
$log = Get-EventLog -List

# Inicializamos la variable
$op = -1

do {

    Write-Host "`MENÚ DE EVENTOS"
    Write-Host "0. Salir"
    Write-Host "---------------------------------------------"

    # Mostrar todos los logs con un número asignado
    for ($i = 0; $i -lt $log.Count; $i++) {
        Write-Host "$($i+1). $($log[$i].LogDisplayName)"
    }

    Write-Host "---------------------------------------------"
    $op = Read-Host "Selecciona una opción"

    # Convertir a entero
    $opInt = $op -as [int]

    # Si es una opción válida
    if ($opInt -ne $null -and $opInt -ge 1 -and $opInt -le $log.Count) {

        $indice = $opInt - 1
        $logelegido = $log[$indice].Log

        Write-Host "Mostrando los últimos 12 eventos de: $logelegido"

        try {
            Get-EventLog -LogName $logelegido -Newest 12
        }
        catch {
            Write-Host "Error al leer el registro."
        }

    }
    elseif ($opInt -ne 0) {
        Write-Host "Opción no válida."
    }

} while ($opInt -ne 0)

Write-Host "Saliendo del programa..."

