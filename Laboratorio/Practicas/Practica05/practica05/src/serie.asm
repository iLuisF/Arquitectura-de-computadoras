
# Programa que calcula la serie.

	.data
m: 	.word 13		# Número de iteraciones.
num: 	.word 0			#Contador auxiliar en punto flotante.
count:	.word 0			#Contador auxiliar en punto flotante.
n: 	.word 0			#Contador auxiliar en punto flotante.
uno: 	.word 1			#Constante en punto flotante.
dos: 	.word 2			#Constante en punto flotante.
cuatro: .word 4			#Constante en punto flotante.
	.text
	lw $t0, m		# t0 = m, es decir, m = número de iteraciones.
	lwc1 $f0, num		# f0 = num, es decir, num = 0
	add $t0, $t0, 1		# m = m + 1	
	lwc1 $f1, n		# n = 0 (Contador flotante)
	move $t1, $zero		# i = 0 (Contador entero)
	lwc1 $f31, uno		# f31 = 1
	neg.s $f30, $f31	# f30 = -1
	lwc1 $f29, dos		# f29 = 2
	lwc1 $f28, cuatro	# f28 = 4
while: 	blt $t0, $t1, end 	# m < i, si es verdad salta a end
	mov.s $f2, $f1		# count = n
	div $t7, $t1, 2		# i mod 2
	mfhi $t7		# temp = i mod 2
if: 	beqz $t7, par  		# ¿count == 0?, si son iguales brinca a par.
	mov.s $f2, $f31		# Si es impar, entonces count = 1
	jal op			# Salta sin pasar por par.	
par:	mov.s $f2, $f30		# Si es par, entonces count = -1
op: 	mul.s $f3, $f2, $f30	# term1 = -1 * count
	mul.s $f4, $f1, $f29	# term2 = n * 2
	add.s $f5, $f4, $f31	# term3 = term2 + 1
	div.s $f6, $f3, $f5	# term4 = term1 / term3
	mul.s $f7, $f6, $f28	# term5 = term4 * 4
	add.s $f8, $f7, $f0	# term6 = term5 + num
	mov.s $f0, $f8		# num = term6
	add.s $f1, $f1, $f31	# n++
	addi $t1, $t1, 1	# i++
	jal while
end: 	#Resultado en $f0
