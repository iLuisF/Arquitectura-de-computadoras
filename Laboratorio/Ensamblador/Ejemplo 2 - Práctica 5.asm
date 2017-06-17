# Calcula los teriminos de  la sucesíon en donde el enésimo
# termino, es la suma de los primeros n naturales.	
	.data
n:	.word	5		# Número de términos a calcular.
r:	.space	20		# Arreglo para almacenar los términos, 4 * n
	.text
	lw	$t0, n		# $t0 := n
	li	$t1, 1		# $t1 := i
	la	$t3, r		# Apuntador al arreglo r
	sw	$t1, 0($t3)	# Guarda el primer término de la sucesión
loop:	beq	$t0, $t1, end	# i == n ?
	lw	$t4, 0($t3)	# Carga r[i]
	addi	$t1, $t1, 1	# i++
	add	$t5, $t4, $t1	# t = r[i-1] + i
	addi	$t3, $t3, 4	# r++
	sw	$t5, 0($t3)	# r[i] = r[i-1] + i
	j 	loop		# Revisa condición
end: 	nop			# Fin del programa
