
#Programa que calcula el maximo comun divisor de dos números.
	
	.data	
a:	.word 15 	# Número a.
b: 	.word 3 	# Número b.
	.text
	lw $t0, a 	# Carga el número a, es decir, $t0 = a.
	lw $t1, b 	# Carga el número b, es decir, $t1 = b.
loop: 	move $t2, $t1 	# mcd = b
	div $t0, $t1 	# $hi = a mod b
	mfhi $t3 	# mod = $hi
	move $t0, $t1 	# a = b
	move $t1, $t3 	# b = mod
until: 	bnez $t3, loop  # ¿mod = 0? Si es falso te regresas a loop	
end:    move $v0, $t2 	# Regresa resultado en v0