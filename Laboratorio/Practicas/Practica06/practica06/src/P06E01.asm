	#Rutina que calcula b^a de forma recursiva con convencion de llamadas a subrutinas.      
        .data                                                                                                                                                                   
a:      .word   5        	# Valor de a                                                                                                                                                       
b:      .word   4               # Valor de b                                                                                                                                                
        .text              
	##Subrutina invocada.                                                                                                                                                     
main:   # Preambulo main               
	subi	$sp, $sp, 24	# 1 Reservar memoria para el marco.(6 registros * 4=24)
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 20	# 4 Establecer $fp          
	##Rutina invocadora.                                                                                                                               
        # Invocacion de mist_1                                                                                                                                                  
	lw	$a0, a		# 1 Pasar argumentos.
	lw 	$a1, b		# 1 Pasar argumentos.
	jal	mist_1		# 3 Brincar a subrutina                
        # Retorno de mist_1                  
        ##Subrutina invocada.                                                                                                                                         
        # Conclusion main                                                                                                                                                       
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	j	finmain		# Final del programa        
	##Subrutina invocada.  
	# mist_1 recibe como argumentos $a0 y $a1                                                                                                                                     	
mist_1: # Preambulo mist_1                                                                                                                                                      
	subi	$sp, $sp, 40	# 1 Reservar memoria para el marco.(10 registros * 4=40)
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 36	# 4 Establecer $fp          	
        move    $s0, $a0        # s0 = a                                                                                                                                                
        move    $t0, $a1        # s1 = b                                                                                                                                                
        li      $t1, 1          # Variable local                                                                                                                                                
loop_1: beqz 	$s0, end_1      # Si a = 0 entonces brinca a end_1                                                                                                                                                 
	##Subrutina invocada.  
        # Invocación de mist_0       
        subi	$sp, $sp, 32	# 1 Reservar memoria para el marco.(8 registros * 4=32)
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 28	# 4 Establecer $fp                                                                                                                                              
	sw 	$a0 , 32($sp)   # a = 32(sp) - Guardar $a0 en el marco anterior
	sw 	$a1 , 28($sp)   # b = 28(sp) - Guardar $a1 en el marco anterior      
        move    $a0, $t0        # Se pasa el argumento $a0                                                                                                                      
        move    $a1, $t1        # Se pasa el argumento $a1     
        jal 	mist_0  	# 3 Brincar a subrutina
        # Retorno de mist_0                                                                                                                                                     
	##Subrutina invocada.        
        move    $t1, $v0        # Copiar el valor.                                                                                                                                                
        subi    $s0, $s0, 1     # s0 = s0 + 1                                                                                                                                                
        lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	addi	$sp, $sp, 32	# 3 Eliminar el marco 
        j       loop_1      	# Saltar a loop_l
	jr	$ra		# 4 Regresar control a rutina invocadora
end_1:  # Conclusion mist_1                                                                                                                                                     
        move    $v0, $t1        # Se retorna el resultado en $v0                                                                                                                
	# mist_0 recibe como argumentos $a0 y $a1                                                                                                                                       
mist_0: # Preambulo mist_0                                                                                                                                                      
        mult    $a0, $a1        # a = a * b  
	##Subrutina invocada.                                                                                                                                              
        # Conclusion mist_0                                                                                                                                                     
        mflo    $v0             # Se retorna el resultado en $v0        
       	jr	$ra		# 4 Regresar control a rutina invocadora
finmain: nop			# Terminamos el programa.
