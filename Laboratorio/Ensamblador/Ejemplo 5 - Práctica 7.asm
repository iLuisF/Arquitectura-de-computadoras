##
#
# Programa que abre un archivo en modo lectura.
#
##	
	.data
sol:	.asciiz	"Introduce el nombre del archivo:\n"
true:	.asciiz	"El archivo se abrio correctamente.\n"
false:	.asciiz "No se pudo abrir el archivo.\n"
buffer:	.space	1024
	.text
	la	$a0, sol		# Carga dirección de cadena a impirmir
	li	$v0, 4			# Código cadena a imprimir
	syscall				# Imprimir cadena
	la	$a0, buffer		# Carga dirección del primer buffer
	li	$a1, 1024		# Tamaño de la primer cadena
	li	$v0, 8			# Código leer cadena
	syscall				# Leer cadena
	# Eliminar salto de linea al final de la cadena
	move	$t0, $zero		# Acumulador
	li	$t1, '\n'		# Caracter salto de linea
loop:	lb	$t2, buffer($t0)	# Carga caracter del buffer
	beq	$t2, $t1, nulo		# Fin de la cadena
	beq	$t2, $zero, nulo	# Fin de la cadena
	addi	$t0, $t0, 1		# Acumulador++
	j	loop
nulo:	sb	$zero, buffer($t0)	# Cracter nulo al final de la cadena
	# Abrir archivo
	la	$a0, buffer		# Apuntador a nombre del archivo.
	li	$a1, 0			# Bandera sólo lectura
	li	$v0, 13			# Código abrir archivo
	syscall
	# Verificar si se abrió el archivo
	li	$t0, -1			# -1 en v0 indica error al arbir archivo
	bne	$v0, $t0, cerrar	# Salto si se abrio el archivo
	# No se pudo abrir el archivo
	la	$a0, false		# Mensaje de error
	j	imprime
	# Siempre cerrar el archivo !!
cerrar:	move 	$a0, $v0		# Descriptor a cerrar
	li	$v0, 16			# Codigo cerrar archivo
	syscall
	la	$a0, true		# Mensaje de exito
imprime:li	$v0, 4			# Imprime mensaje
	syscall
	li	$v0, 10			# Fin del programa
	syscall
	