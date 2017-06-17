# 	Rutina que calcula el coeficiente binomial de forma recursiva con convención
# de llamadas a subrutinas.
#	
	.data
n:	.word	40		# Valor de n
k: 	.word 	5		# Valor de k
	.text
	##Subrutina invocada.
main:	# Preambulo main
	subi	$sp, $sp, 24	# 1 Reservar memoria para el marco.
	sw	$ra, 16($sp)	# 3 Guardar $ra
	sw	$fp, 20($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 20	# 4 Establecer $fp
	## Tarea
	li	$s0, 1		# Cargar como variable global la constate 1								
	##Rutina invocadora.
	# Invocacion
	lw	$a0, n		# 1 Pasar argumentos
	lw 	$a1, k		# 1 Pasar argumentos
	jal	bin		# 3 Brincar a subrutina
	# Conlcusion main
	lw	$ra, 16($sp)	# 3 Restaurar $ra
	lw	$fp, 20($sp)	# 4 Restaurar $fp
	j	endmain		# Final del programa
	##Subrutina invocada.
bin:	# Preambulo bin
	subi	$sp, $sp, 32	# 1 Reservar memoria para el marco								
	sw	$ra, 8($sp)	# 3 Guardar $ra
	sw	$fp, 12($sp)	# 4 Guardar $fp
	addi	$fp, $sp, 28	# 4 Establecer $fp												
	# Tarea
	beqz	$a1, else1	# Si k == 0, pasa a los casos base
	beqz	$a0, else2	# Si n == 0 pasa a los casos base
	sw	$a0, 32($sp)	# Guardar $a0 en el marco anterior
	sw	$a1, 28($sp)	# Guardar $a1 en el marco anterior
	# Invocacion 		# bin(n-1, k)
	subi	$a0, $a0, 1	# 1 Pasar argumentos
	jal	bin		# 3 Brincar a subrutina
	# Retorno
	move	$v0, $t0	# Copiar el valor de bin(n-1, k)
	lw	$t1, 32($sp)	# Restaurar $t1 con el valor de n
	lw 	$t2, 28($sp)	# Restaurar $t1 con el valor de k
	# Invocacion 		# bin(n-1, k -1)
	subi	$a0, $t1, 1	# 1 Pasar argumentos, a0 = n - 1
	subi 	$a1, $t2, 1	# 1 Pasar argumentos, a1 = k - 1
	sw	$t0, 16($sp)	# 2 Guardar $t0
	jal	bin		# 3 Brinca subrutina
	# Retorno
	lw	$t0, 16($sp)	# 1 Restaurar $t0
	add	$t0, $t0, $v0   # bin(n-1, k) + bin(n-1, k - 1)
	j	end		# Fin then
else1:	li	$t0, 1		# Caso base
	j 	end
else2:  move 	$t0, $zero	# Caso base	
end:	# Conclusion
	move	$v0, $t0	# 1 Valores de retorno
	lw	$ra, 8($sp)	# 2 Restaurar $ra
	lw	$fp, 12($sp)	# 2 Restaurar $fp
	addi	$sp, $sp, 32	# 3 Eliminar el marco 
	jr	$ra		# 4 Regresar control a rutina invocadora
endmain:nop			# Terminamos el programa.
