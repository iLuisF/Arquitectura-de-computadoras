# 
# Programa que calcula el enésimo término de la sucesión de Fibonacci.
#

	.data
n:	.word	5		# La n que queremos calular	

	.text
	li    $t0, 1		# Carga f1 = 1
	li    $t1, 1            # Carga f2 = 1
	move  $t2, $zero        # Carga s = 0 
	li    $t3, 2		# Carga i = 2
	lw    $t4, n            # Carga n
	
loop:	bgt   $t3, $t4, end     # Terminamos si i > n
	move  $t2, $t0          # s = f1
	add   $t0, $t1, $t0     # f1 = f1 + f2
	move  $t1, $t2          # f2 = s
	addi  $t3, $t3, 1       # i++
	j     loop              # Regresa a revisar condición

end:    move  $v0, $t0     	# Regresa resultado en v0
