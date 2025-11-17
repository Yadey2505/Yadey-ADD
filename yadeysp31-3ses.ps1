param (
    [datetime]$fechaini,
    [datetime]$fechafin 
)

Write-Host "Se mostraran los inicios de sesion desde $fechaini hasta $fechafin"
Write-Host ""

# Obtener eventos ID 4624 (inicio de sesion)
$evento = Get-EventLog -LogName Security -InstanceId 4624 |
    Where-Object {
        $_.TimeGenerated -ge $fechaini -and
        $_.TimeGenerated -le $fechafin
    }

# Excluir SYSTEM
$evento = $evento | Where-Object {
    $_.ReplacementStrings[5] -ne "SYSTEM"
}

# Mostrar resultados
foreach ($ev in $evento) {
    $fecha = $ev.TimeGenerated
    $usuario = $ev.ReplacementStrings[5]

    Write-Host "Fecha: $fecha  Usuario: $usuario"
}
