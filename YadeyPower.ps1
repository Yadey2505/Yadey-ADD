#Menu 
Function showmenu {
    Write-Host ""
    Write-Host "### Menu Yadey Rivero ####" -ForegroundColor cyan
    Write-Host ""
    Write-Host "1. Pizzas"
    Write-Host "2. Dias"
    Write-Host "3. Menu Usuarios"
    Write-Host "4. Menu Grupos"
    Write-Host "6. Validar contrasena"
    Write-Host "7. Fibonacci"
    Write-Host "8. Monitoreo"
    Write-Host "9. Espacio"
    Write-Host "0. Salir"
} 

#Script Pizza

Function Pizza {
    
    #Preguntamos al usuario si quiere pizza vegetariana
    
    $tipo= Read-Host "Quieres pizza vegetariana?"

    # Si nos dice que si entonces preguntamos que ingrediente quiere
        if ($tipo -eq "si"){
            Write-Host "Has elegido pizza vegetariana."
            Write-Host "Los ingredientes que puedes elegir son Tofu o Pimiento"
            $ingrediente = Read-Host "Elige uno: "

    # Asginamos el ingrediente
                if ($ingrediente -eq "Tofu" -OR $ingrediente -eq "Pimiento"){
                    $ingredientefinal = $ingrediente
                }
    # Si el ingrediente no coincide mostramos que no lo tenemos            
                else {
                    Write-Host "Ese ingrediente no lo tenemos."
                    
                }
            }
    # Si nos dice que no mostramos los ingredientes
       
            elseif ($tipo -eq "no")  {
                Write-Host "Has elegido no vegetariana."
                Write-host "Los ingredientes que puede elegir son:Salmon, Jamon o Peperoni"   
                $ingrediente = Read-Host "Elige uno "

                    #Asignamos cada ingrediente

                    if ($ingrediente -eq "Salmon" -OR $ingrediente -eq "Jamon" -OR $ingrediente -eq "Peperoni"){
                    $ingredientefinal = $ingrediente
                    }
                    else {
                        Write-Host "Ese ingrediente no lo tenemos."
                    
                    }
               
                }
            else {
                Write-host "ERROR: Introduce si o no"
            }
        
       
        #Mostramos todos los ingredientes finales
           Write-Host "..................................."
           Write-Host "La pizza seleccionada lleva: Mozzarella, Tomate y $ingredientefinal"

        #Por ultimo decimos si es vegetariana o no 
            if ($tipo -eq "si"){
                Write-Host "Tu pizza es Vegeteriana"
            }

            else {
                Write-Host "Tu pizza No es Vegetariana"
                }
            }


Function dias{
    #Asignamos en un array los dias
    $dia_mes = 31,29,30,31,30,31,30,31,30,31,30,31

    #Inicializamos los pares e impares en 0
    $par = 0
    $impar = 0

    #Recorremos los dias 
        foreach ($mes in $dia_mes){
            
            #Iniciamos en 1 si es menor que el dia del mes entonces incrementamos
            for($d = 1; $d -le $mes; $d++){
            #Si es divisible por 2 y de resto 0 entonces es par
                if ($d %2 -eq 0){
                    $par++ 
                    }
            #Si no es es impar
                else{
                    $impar++}
            }
        }
        #Mostramos cuantos impares y pares
        Write-Host "Pares: $par"
        Write-Host "Impar: $impar"
}

#Funcion para menu de usuarios
Function menu_usuarios{
 Function showmenu{
        Write-Host ""
        Write-Host "### Menu de Usuarios ###" -ForegroundColor red
        Write-Host "1. Listar Usuarios"
        Write-Host "2. Crear Usuarios"
        Write-Host "3. Elimnar Usuarios"
        Write-Host "4. Modificar Usuarios"
        Write-Host "0. SALIR"
        Write-Host ""
        }

            Function listar {
            #Optemos los usuarios del sistema
                Get-LocalUser
                Write-Host ""
                
            }
            
            Function crear {
            #Pedimos el nombre del usaurio 
                $usuario_crear = Read-Host "Dime el nombre del usuario"

            #Pedimos la contrasena y la guardamos de forma segura
                $contrasena = Read-Host "Dime una contrasena" -AsSecureString
                
            #Creamos el usuario con el nombre y la contrasena que nos ha pasado el usuario
                New-LocalUser -name $usuario_crear -Password $contrasena

            #Mostramos el usuario 
                Write-Host "Has creado el usuario $usuario_crear"
                Write-Host ""
            }

            Function borrar {
            #Pedimos el usuario a eliminar
                $usuario_elim = Read-Host "Dime el usuario que quieres eliminar "

            #Borramos el usuario
                Remove-LocalUser -name $usuario_elim -Confirm

                Write-Host ""
            }

            Function modificar{
            #Pedimos el nombre del usuario que quiera renombrar
                $usuario_modi = Read-Host "Dime el usuario a renombrar "

            #Pedimos el nuevo nombre
                $nuevo_nom = Read-Host "Dime el nuevo nombre de $usuario_modi  " 

            #Renombramos el usuario
                Rename-LocalUser -Name $usuario_modi -NewName $nuevo_nom
                Write-Host ""
                 }

showmenu
    while (($op =Read-Host -Prompt "Selecciona una opcion")-ne 0){

    switch ($op){

        1 {
            listar
            break
        }

        2 {
            crear
            break
            }

        3 {
            borrar
            break
            }
        
        4 {
            modificar
            break
        }
        
        0 {"Exit";break}


    }
    Write-Host ""
    showmenu
   }
}
    


Function menu_grupos{
    Function showmenu{
        Write-Host ""
        Write-Host "### Menu Grupos ###" -Foreground Cyan
        Write-Host "1. Listar grupos y miembros" 
        Write-Host "2. Crear grupo"
        Write-Host "3. Eliminar grupo"
        Write-Host "4. Crear miembro en un grupo"
        Write-Host "5. Eliminar miembro de un grupo"
        Write-Host "0. SALIR"
        Write-Host ""
        }

    #Listamos los usuarios
    Function listargrp{
        $grupos = Get-LocalGroup
        
        #Recorremos la lista de los grupos y optenemos el nomobre
        foreach ($lista in $grupos){
        
        #Mostramos el nombre dle grupo
            Write-Host "Grupo: $($lista.Name)"

        #Optenemos los miembros de cada grupo    
            $miembros = Get-LocalGroupMember -Group $lista.Name

        #Recorremos cada miembro y optenemos su nombre y lo mostramos
            if ($miembros){
                foreach ($miembro in $miembros){
                    Write-Host "Miembro: $($miembro.Name)"
                }
           }
        #Si el grupo no tiene niembros mostramos que no miembros    
            else{
                Write-Host "Este grupo no tiene miembros"
                }
            Write-Host "----------------------------"
            
        }
    }

    Function creargrp{
        #Pedimos al usuario el nombre del grupo
        $new_grupo = Read-Host "Dime el nombre del grupo"

        #Creamos el grupo con ese nombre
        New-LocalGroup -Name $new_grupo
    }

    Function eliminargrp{
        #Pedimos al usuario el nombre del grupo que quiere eliminar
        $del_grupo = Read-Host "Dime el nombre del grupo"

        #Borramos ese grupo
        Remove-LocalGroup -Name $del_grupo
    }

    Function crearmmb{
        $new_member = Read-Host "Dime el nombre del miembro"
        $grupo_member = Read-Host "Dime el nombre del grupo"
        Add-LocalGroupMember -Group $grupo_member -Member $new_member
    }

    Function elimarmmb{
        $del_member = Read-Host "Dime el nombre del miembro"
        $del_grupo = Read-Host "Dime el nombre del grupo"
        Remove-LocalGroupMember -Group $del_grupo -Member $del_member

    }

showmenu
    while (($op =Read-Host -Prompt "Selecciona una opcion")-ne 0){
    switch ($op){
        
        1{
            listargrp
            break
        }

        2{
            creargrp
            break
        }

        3{
            eliminargrp   
            break
        }
     
        4{
            crearmmb
            break
        }

        5{
          elimarmmb  
          break
        }

        0 {"Exit";break}
        
        }  

        Write-Host ""
        showmenu
    }
}


Function diskp{
} 

Function contraseñavalida{
    $contrasena_seg = Read-Host "Dime una contraseña" -AsSecureString
    $contrasena = [System.net.NetworkCredential]::new("",$contrasena_seg).Password

    Function validar($contrasena) {
        if ($contrasena.Length -lt 8){
        return $false
        }
        
        if ($contrasena -notmatch '[a-z]'){
        return $false
        }
        if ($contrasena -notmatch '[A-Z]'){
        return $false
        }
        if ($contrasena -notmatch '\d'){
        return $false 
        }
        if ($contrasena -notmatch '[^a-zA-Z0-9]'){
        return $false
        }
        return $true
    }
    
    if( validar $contrasena){
    Write-Host ""
    Write-Host "contraseña valida" -Foreground Green
    }
    else{
    Write-Host ""
    Write-Host "Contraseña no valida" -Foreground Red
    }

}


Function fibonacci{
    #Ponemos los dos primeros numeros de fibonacci
    $n1 = 0
    $n2 = 1
    #El usuario decide cuantos numero quiere imprimir
    $veces = Read-Host "Dime cuantas veces"

    Write-Host "Secuencia de Fibonacci:"

    #Ejecutamos el bucle mientras sea menor o igual a las veces haya introducido el usuario e incrementamos 
    for ($i = 0; $i -lt $veces; $i++) {
       #Hacemos que imprima los dos primero numero (0 y 1)
        if ($i -lt 2) {
            $resultado = $i
        } else {
        #Calculamos el siguiente numero con una suma
            $resultado = $n1 + $n2
        #Actualizamos los valores para que los numeros sean los dos ultimos usados 
            $n1 = $n2
            $n2 = $resultado
        }
        #Los imprimimos por pantalla todo seguido
        Write-Host " " $resultado -NoNewLine
    }
        Write-Host ""

}

Function monitoreo{
     (Get-Counter '\Procesador(_Total)\% de tiempo de procesador' -SampleInterval 5 -MaxSamples 6 ).CounterSamples.CookedValue |
         Measure-Object -Average | 
        ForEach-Object {"Promedio de CPU: $([math]::Round($_.Average,2)) %"}
}


Function alertaEspacio{
    $ruta = "$env:USERPROFILE\espacio.log"

    Get-PSDrive -PSProvider 'FileSystem' | ForEach-Object {
    $total = $_.Used + $_.Free
    if ($total -eq 0){ return }

    $porcent_libre = ($_.Free / $total) * 100
    $GB = $_.Free / 1GB

    Write-Host "La unidad $($_.Name): tiene $GB GB Libres ($porcent_libre GB)"

    if ($porcent_libre -lt 10){
        $mensaje = "Alerta: Unidad $($_.Name) solo tiene $porcent_libre ($GB GB)"
        $mensaje >> $ruta
    }
    }

}

Function copiasMasivas{
} 

Function automatizarps{
}


Function barrido{
}


Function evento{
}


Function Agenda{

}

Function limpieza{

}
showmenu
while (($op =Read-Host -Prompt "Selecciona una opcion")-ne 0){


    switch ($op){

        1 {
            Pizza
            break
            
            }

        2{
        
            dias
            break
        
        }

        3{
            menu_usuarios
            break
        }
        4{
             menu_grupos
             break
        }
        5{
            break
        }
        6{
            contraseñavalida
            break
        }
        7{
            fibonacci
            break
        }
        8{
            monitoreo
            break
        }
        9{
            alertaEspacio
            pause;
            break
        }
        10{
        break
        }
        11{
        break
        }
        12{
        break
        }
        13{
        break
        }
        14{
        break
        }
        15{
        break
        }



        0 {"Exit";break}
 
  
    
    }
        Write-Host ""
        showmenu
        

}