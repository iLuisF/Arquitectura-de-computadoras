
#Sabemos que n = n - n = 0, n = b + n, entonces n = b + 0. Por lo tanto n = b
#Pasando estas operaciones a ensamblador tenemos que el registro n sera igual al registro b.

	.data
n: 	.word 5 		# n = 5
b:	.word 7			# b = 7
	.text		
	lw $t0, n		# t0 = n = 5
	lw $t1, b		# t1 = b = 7
	sub $t0 , $t0 , $t0 	# n = n - n = 0
	add $t0 , $t1 , $t0	# n = b + n, es decir, n = b + 0. Por lo tanto n = b
	move $v0, $t0		# v0 = 7