##
#
# Programa que determina si dos cadenas son iguales.
#
##
	.data
bufr_1: .space	1024
bufr_2: .space	1024
sol:	.asciiz	"Introduce dos cadenas separadas por un salto de línea:\n"
true:	.asciiz "Las cadenas son iguales\n"
false:	.asciiz	"Las cadenas son distintas\n"
 	.text
	la	$a0, sol		# Carga dirección de cadena a impirmir
	li	$v0, 4			# Código cadena a imprimir
	syscall				# Imprimir cadena
	la	$a0, bufr_1		# Carga dirección del primer buffer
	li	$a1, 1024		# Tamaño de la primer cadena
	li	$v0, 8			# Código leer cadena
	syscall				# Leer cadena
	la	$a0, bufr_2		# Carga dirección del segudo buffer
	li	$a1, 1024		# Tamaño de la segunda cadena
	li	$v0, 8			# Código leer cadena
	syscall				# Leer cadeba
	move 	$t0, $zero		# Acumilador en 0
loop:	lb	$t1, bufr_1($t0)	# Carga carcater, primer cadena
	lb	$t2, bufr_2($t0)	# Carga carater, segunda cadena
	bne	$t1, $t2, distint	# Si son distintas termina
	beq	$t1, $zero, iguales	# Si es caracter nulo, fin programa
	addi	$t0, $t0, 1		# Acumulador++
	j loop			
iguales:la	$a0, true		# Cadenas iguales
	j	imprime
distint:la	$a0, false		# Cadenas distintas
imprime:li	$v0, 4
	syscall	
	li	$v0, 10			# Fin del programa
	syscall