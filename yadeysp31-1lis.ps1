function ShowMenu {
    Write-Host "---------------------------"
    Write-Host "     MENU EJERCICIO 1"
    Write-Host "---------------------------"
    Write-Host "1. Listado de eventos del sistema"
    Write-Host "2. Errores del sistema del último mes"
    Write-Host "3. Advertencias de aplicación de esta semana"
    Write-Host "Pulsa Enter para salir"
    Write-Host "---------------------------"
}

ShowMenu

# El bucle continúa mientras la opción NO esté vacía
while (($opcion = Read-Host "Elige una opción (1-3)") -ne '0') {

    switch ($opcion) {

        '1' {
           Get-EventLog -LogName System -Newest 20
       }

        '2' {
           Get-EventLog -LogName System -EntryType Error -After (Get-Date).AddDays(-30)
        }

        '3' {
           Get-EventLog -LogName Application -EntryType Warning -After (Get-Date).AddDays(-7)
        }

        default {
            Write-Host "Opción no válida, intenta de nuevo."
        }
    }

    Write-Host ""
    ShowMenu
}

Write-Host "Programa finalizado."
