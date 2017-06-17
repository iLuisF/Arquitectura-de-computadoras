
#Programa para calcular el cociente y residuo sin usar div.


	.data
divid: 	.word 12 		# Dividendo
divis: 	.word 3     		# Divisor
	.text
	lw $t0, divid  		# Carga el dividendo, es decir, $t0 = divid
	lw $t1, divis  		# Carga el divisor, es decir, $t1 = divis
	li $t2, 1  		# p = 1
	move $t3, $zero 	# q = 0
if: 	blt $t0, $t1, endIf 	# Terminamos si no se cumple que divid < divis
	sub $t4, $t0, $t1 	# s = divid - divis
while:  blt $t4, $t3, end   	# Terminamos si no se cumple que s < q
	mul $t3, $t1, $t2 	# q = (divis * p)
	addi $t2, $t2, 1 	# p++
	j while   		# Regresa a revisar condición
end:  	subi $t2, $t2, 1 	# p = p - 1 (Cociente)
	sub $t0, $t0, $t3 	# divid = divid - mul (Residuo)
	move $v0, $t2   	# $v0 = cociente
	move $v1, $t0  		# $v1 = residuo
endIf: 				# Error: El denominador debe ser menor. Ya no se calcula nada.
	


