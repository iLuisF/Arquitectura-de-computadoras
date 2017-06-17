	.data
	
cad1:	.asciiz "\nEscriba el comando que desea ejecutar\n"
com1:	.asciiz "help"
com2:	.asciiz "rev"
com3:	.asciiz "cat"
com4:	.asciiz "exit"
com5:	.asciiz "ls" 
help:	.asciiz "help.txt"
rev:	.asciiz	"rev.txt"
cat:	.asciiz "cat.txt"
exit:	.asciiz "exit.txt"
help1:	.asciiz "help1.txt"
ls:	.asciiz "ls.txt"
errorc:	.asciiz "\ncomando desconocido\n"
errorf:	.asciiz "\nNo se pudo leer el archivo \n"
aux1:	.asciiz "\nEscriba la cadena la cual se le aplicara la funcion rev\n"

buff2:	.space 5

	.text
inicio:		
	la $a0 , cad1			# Se carga la cadena de presentacion
	li $v0 , 4			# Se carga la intruccion de Imprimir cadena 	
	syscall				# Imprime la cadena

	la $a0 , 1024 			# se carga la cantidad de memoria
	li $v0 , 9 			# cargamos la intruccion de asignar memoria
	syscall				# aisgnamos la memoria
	move $t0 , $v0			# movemos la direcion de la memoria
	move $a0 , $v0			# movemos la direccion de meria a a0
	la $a1 , 1024			# se carga el espacio 
	li $v0 , 8			# se carga la opcion leer cadena
	syscall				# se lee la cadena
	

	la $a0 , com1			# se carga el primer comando
loop1:	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , chelp 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , dif1		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop1				# se salta al inicio del ciclo

chelp:
	beq $t1 , 10 , help2		# saltamos si solo se escribio el comando help
	bne $t1 , 32 , error1		# si tiene mas letras mandamos un error
	
loop2:	
	
	addi $t0 , $t0 , 1		# sumamos al contador 1
	lb $t1 , ($t0) 			# cargamoes el bit que esta en la posicon de t4
	bne $t1 , 32 ,chelp1		# saltamos si ya no hay mas espacios
	j loop2				# saltamos al inicio del loop


chelp1:
	move $t3 , $t0			# guardamos lo que esta en $t0
	la $a0 , com4			# cargamos la segunda cadena
loop3:
	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , hexit 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , chelp2		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop3				# se salta al inicio del ciclo
	
chelp2:
	move $t0 , $t3			# restauramos el contador
	la $a0 , com2			# cargamos la segunda palabra 
loop4:
	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , hrev	 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , chelp3		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop4				# se salta al inicio del ciclo
chelp3:	
	move $t0 , $t3			# restauramos el contador
	la $a0 , com3			# cargamos la segunda palabra
	
loop5:
	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , hcat	 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , chelp4		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop5				# se salta al inicio del ciclo
chelp4:
	move $t0 , $t3			# restauramos el contador
	la $a0 , com5			# cargamos la segunda palabra
	
loop6:
	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , hls	 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , chelp5		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop6				# se salta al inicio del ciclo
	
chelp5:
	move $t0 , $t3			# restauramos el contador
	la $a0 , com1			# cargamos la segunda palabra
	
loop7:
	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , hhelp	 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , error1		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop7				# se salta al inicio del ciclo
		
error1:
	la $a0 , errorc			# cargamos la cadena de error
	li $v0 , 4			# cargamos la instruccion de imprimir cadena
	syscall				# se imprime la cadena
	j inicio			# saltamos al inicio
	
help2:
	la $a0 , help			# cargamos el nombre del archivo help.txt
	j loopg				# saltamos al loop para escribir el archivo
hexit:
	la $a0 , exit			# cargamos el nombre del archivo exit.txt
	j loopg				# saltamos al loop para escribir el archivo

hrev: 
	la $a0 , rev			# cargamos el nombre del archivo rev.txt
	j loopg				# saltamos al loop para escribir el archivo
	
hcat:	
	la $a0 , cat			# cargamos el nombre del archivo cat.txt
	j loopg				# saltamos al loop para escribir el archivo
	
hls:	la $a0 , ls			# cargamos el nombre del archivo ls.txt
	j loopg				# saltamos al loop para escribir el archivo
	
hhelp:	la $a0 , help1			# cargamos el nombre del archivo help1.txt
	j loopg				# saltamos al lopp general para escribir el archivo
	
loopg:	
	li $a1 , 0			# bandera para abrir el archivo
	li $v0 , 13			# se carga la intruccion de abrir archivo
	syscall				# se abre el archivo
	move $t0 , $v0			# guardamos lo que esta en $v0
loop8:  
	move $a0 , $t0			# cargamos lo que estaba en a0
	la $a1 , buff2			# se le da el tamaño del buffer
	li $a2 , 5			# se carga el tamaño del texto	
	li $v0 , 14			# se carga la intruccion de Leer archivo
	syscall				# se lee archivo	
	move $t4 , $v0			# guardamos lo que esta en v0
	move $a0  , $a1			# se carga lo que se tiene que escribir
	li $v0 , 4			# se carga la intruccion de escribir	
	blt $t4 , 5 , cerrar1		# si se termino de escribir el archivo saltamos a cerrar el archivo	
	syscall				# se escribe
	j loop8 			# se salta al inicio del ciclo
	
cerrar1:	
	move $a0 , $t0			# movemos el descriptor denuevo a a0
	li $v0 , 16			# se carga la instruccion de cierre de archivo
	syscall				# se cierra el archivo
	j inicio			# saltamos al inicio
	
dif1:	
	la $a0 , com4			# se carga el comando exit
loop9:	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , cexit 	# si son iguales saltamos a lo que hace el comando exit
	bne $t1 , $t2 , dif2		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop9				# se salta al inicio del ciclo
	
cexit:
	li $v0 , 10 			# se carga la intruccion de terminar ejecucion
	syscall 			#se termina la ejecuccion
	
dif2:	
	
	la $a0 , com3			# se carga el comando cat
loop10:	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , ccat	 	# si son iguales saltamos a lo que hace el comando help
	bne $t1 , $t2 , dif3		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop10			# se salta al inicio del ciclo
	
ccat:
	bne $t1 , 32 , error1		# si tiene mas letras se manda un error	
loop11:
	addi $t0 , $t0 , 1		# sumamos al contador 1
	lb $t1 , ($t0) 			# cargamoes el bit que esta en la posicon de t0
	bne $t1 , 32 , 	ccat1		# saltamos si ya no hay mas espacios
	j loop11
	
ccat1:	
	li $a0 , 1024			# cargamos la cantidad de memoria que necesitamos
	li $v0 , 9			# cargamos la intruccion de asignanar memoria
	syscall				# se asigna la memoria
	
	move $t4 , $v0			# guardamos la referencia a la memoria que acabamos de asignar
	move $t3 , $t0			# guardamos el inicio de la cadena
	move $t5 , $t4			# guardamos el inicio de la cadena
loop12:
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	beq $t1 , 46 , loop13		# saltamos hasta que encontramos un punto
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	j loop12			# saltamos al inicio del loop
	
loop13:
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	beq $t1 , 32 , ccat2		# saltamos hasta que encontramos un espacio 
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	j loop13			# saltamos al inicio de loop

ccat2:	
	sb $zero , ($t4)		# le ponemos al final de la cadena el caracter nulo
	move $a0 , $t5			# movemos el inicio de la cadena a a0
	li $a1 , 0			# bandera para abrir el archivo
	li $v0 , 13			# se carga la intruccion de abrir archivo
	syscall				# se abre el archivo
	beq $v0 , -1 , error2		# verificamos que se haya habierto el archivo
	move $t6 , $v0			# movemos el descriptor
loop14:  
	move $a0 , $t6			# cargamos lo que estaba en a0
	la $a1 , buff2			# se le da el tamaño del buffer
	li $a2 , 5			# se carga el tamaño del texto	
	li $v0 , 14			# se carga la intruccion de Leer archivo
	syscall				# se lee archivo	
	move $t7 , $v0			# guardamos lo que esta en v0
	move $a0  , $a1			# se carga lo que se tiene que escribir
	li $v0 , 4			# se carga la intruccion de escribir
	blt $t7 , 5 , ccat3		# si se termino de escribir el archivo saltamos a cerrar el archivo		
	syscall				# se escribe
	
	j loop14			# se salta al inicio del ciclo
	
ccat3:	
	move $a0 , $t6			# movemos el descriptor denuevo a a0
	li $v0 , 16			# se carga la instruccion de cierre de archivo
	syscall				# se cierra el archivo
	
loop15:
	lb $t1 , ($t0) 			# cargamoes el bit que esta en la posicon de t0
	bne $t1 , 32 , 	ccat4		# saltamos si ya no hay mas espacios
	addi $t0 , $t0 , 1		# sumamos al contador 1
	j loop15
ccat4:	
	li $a0 , 1024			# cargamos la cantidad de memoria que necesitamos
	li $v0 , 9			# cargamos la intruccion de asignanar memoria
	syscall				# se asigna la memoria
	
	move $t4 , $v0			# guardamos la referencia a la memoria que acabamos de asignar
	move $t3 , $t0			# guardamos el inicio de la cadena
	move $t5 , $t4			# guardamos el inicio de la cadena
		
loop16:
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	beq $t1 , 46 , loop17		# saltamos hasta que encontramos un punto
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	j loop16			# saltamos al inicio del loop

loop17:
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	beq $t1 , 32 , ccat5		# saltamos hasta que encontramos un espacio 
	beq $t1 , 10 , ccat5		# saltamos si encontramos un salto de linea
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	j loop17			# saltamos al inicio de loop

ccat5:
	subi $t4 , $t4 , 1		# regresamos un caracter
	sb $zero , ($t4)		# le ponemos al final de la cadena el caracter nulo
	move $a0 , $t5			# movemos el inicio de la cadena a a0
	li $a1 , 0			# bandera para abrir el archivo
	li $v0 , 13			# se carga la intruccion de abrir archivo
	syscall				# se abre el archivo
	beq $v0 , -1 , error2		# verificamos que se haya habierto el archivo
	move $t6 , $v0			# movemos el descriptor
		

loop18:  
	move $a0 , $t6			# cargamos lo que estaba en a0
	la $a1 , buff2			# se le da el tamaño del buffer
	li $a2 , 5			# se carga el tamaño del texto	
	li $v0 , 14			# se carga la intruccion de Leer archivo
	syscall				# se lee archivo	
	move $t7 , $v0			# guardamos lo que esta en v0
	move $a0  , $a1			# se carga lo que se tiene que escribir
	li $v0 , 4			# se carga la intruccion de escribir
	blt $t7 , 5 , ccat6		# si se termino de escribir el archivo saltamos a cerrar el archivo		
	syscall				# se escribe
	
	j loop18			# se salta al inicio del ciclo	
	
ccat6:	
	move $a0 , $t6			# movemos el descriptor denuevo a a0
	li $v0 , 16			# se carga la instruccion de cierre de archivo
	syscall				# se cierra el archivo
	j inicio			# salta a inicio		
error2:
	la $a0 , errorf			# cargamos la cadena de error
	li $v0 , 4			# cargamos la intruccion de imprimir cadena
	syscall				# se imprime la cadena
	j inicio			# saltamos a inicio
	
dif3:			
	
	la $a0 , com2			# se carga el comando rev
loop19:	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , crev	 	# si son iguales saltamos a lo que hace el comando rev
	bne $t1 , $t2 , dif4		# si son diferentes saltamos y probamos con otro
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop19			# se salta al inicio del ciclo					
crev:	
	beq $t1 , 10 , loop20		# saltamos si el siguiente caracter es un salto de linea
	bne $t1 , 32 , error1 		# si tiene mas letras se manda un error
loop20:
	addi $t0 , $t0 , 1		# sumamos al contador 1
	lb $t1 , ($t0) 			# cargamoes el bit que esta en la posicon de t0
	bne $t1 , 32 , 	crev1		# saltamos si ya no hay mas espacios
	j loop20

crev1:	
	li $a0 , 1024			# cargamos la cantidad de memoria que necesitamos
	li $v0 , 9			# cargamos la intruccion de asignanar memoria
	syscall				# se asigna la memoria
	move $t4 , $v0			# guardamos la referencia a la memoria que acabamos de asignar
	move $t3 , $t0			# guardamos el inicio de la cadena
	move $t5 , $t4			# guardamos el inicio de la cadena
	beq $t1 , 10 , crev4		# saltamos a crev4 si no hay archivo que leer
	beq $t1 , 0 , crev4		# saltamos a crev4 si no hay archivo que leer
loop21:
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	beq $t1 , 46 , loop22		# saltamos hasta que encontramos un punto
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	j loop21			# saltamos al inicio del loop
	
loop22:
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	beq $t1 , 32 , crev2		# saltamos hasta que encontramos un espacio 
	beq $t1 , 10 , crev2		# saltamos si encontramos un salto de linea
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	
	
	j loop22			# saltamos al inicio de loop

crev2:	
	
	sb $zero , ($t4)		# le ponemos al final de la cadena el caracter nulo
	move $a0 , $t5			# movemos el inicio de la cadena a a0
	li $a1 , 0			# bandera para abrir el archivo
	li $v0 , 13			# se carga la intruccion de abrir archivo
	syscall				# se abre el archivo
	beq $v0 , -1 , error2		# verificamos que se haya habierto el archivo
	move $t6 , $v0			# movemos el descriptor
	li $a0 , 1024			# cargamos la cantidad de memoria
	li $v0 , 9			# cargamos la intruccion de asignar memoria
	syscall				# se asigna la memoria
	move $t8 , $v0 			# guradamos la direccion de memoria
	move $s1 , $v0			# guardamos el inicio de la cadena
	

loop23:
	move $t9 , $zero		# contador en 0
	move $a0 , $t6			# cargamos lo que estaba en a0
	la $a1 , buff2			# se le da el tamaño del buffer
	li $a2 , 5			# se carga el tamaño del texto	
	blt $v0 , $a2 , crev3		# saltamos si leimos menos caracteres de los que deveriamos leer
	li $v0 , 14			# se carga la intruccion de Leer archivo
	syscall				# se lee archivo	
loop24:	
	blt  $v0 , $t9 , loop23		# salta si ya leiste todo el buffer
	lb $t7 , buff2($t9)		# cargamos el caracter
	sb $t7 , ($t8)			# gurdamos el caracter
	addi $t9 , $t9 , 1		# acumulador mas 1
	addi $t8 , $t8 , 1		# movemos al siguiente caracter
	j loop24			# se salta al inicio del ciclo
	
crev3:
	move $a0 , $t6			# movemos el descriptor denuevo a a0
	li $v0 , 16			# se carga la instruccion de cierre de archivo
	syscall				# se cierra el archivo
	subi $t8 , $t8 , 1		# restamos uno a t8
loop25:	
	blt $t8 , $s1 , inicio		# saltamos si terminanos de escribir el primer caracter
	move $t9 , $zero		# contador en 0
	subi $t8, $t8 , 1		# quitamos un espacio
	lb $a0 , ($t8)			# cargamos el caracter
	li $v0 , 11			# cargamos la intruccion de imprimir caracter
	syscall				# imprimimos el caracter
	j loop25				

crev4:
	la $a0 , aux1			# cargamos el mensaje
	li $v0 , 4			# cargamos la instruccion de imprimir cadena
	syscall				# imprimimos la cadena
	
	move $a0 , $t5			# movemos la direccion del buffer a a0
	li $a1 , 1024			# el tamaño de la cadena
	li $v0 , 8			# cargamos la operacion de leer cadena
	syscall				# leemos la cadena
	
	move $t9 , $zero		# contador en 0
loop26:
	lb $t1 , ($t5)			# cargamos el caracter
	beq $t1 , 10 , 	loop27		# saltamos si la cadena temina
	beq $t1 , 0 , 	loop27		# saltamos si la cadena temina
	addi $t9 , $t9 , 1		# contador mas 1
	addi $t5 , $t5 , 1		# siguiente posicion
	j loop26			# vamos al principio del loop
	
	
loop27:	
	blt $t9 , $zero , inicio	# saltamos cuando termine de escribir la cadena
	lb $a0 , ($t5)			# cargamos el caracter
	li $v0 , 11			# cargamos la intruccion de imprimir caracter
	syscall				# imprimimos el caracter
	subi $t9 , $t9 , 1		# contador menos 1
	subi $t5 , $t5 , 1		# posicion menos 1
	j loop27			# vamos al inicio del loop

dif4:	
	la $a0 , com5			# se carga el comando rev
loop28:	lb $t1 , ($t0)			# Cargamos el caracter de la primera cadena
	lb $t2 , ($a0) 			# Cargamos el caracter de la segunda cadena
	beq $t2 , $zero , cls	 	# si son iguales saltamos a lo que hace el comando ls
	bne $t1 , $t2 , error1		# si son diferentes mandamos error
	addi $t0 , $t0 ,  1		# acumulador mas 1
	addi $a0 , $a0 , 1		# acumulador de la segunda palabra 
	j loop28			# se salta al inicio del ciclo					
cls:
	bne $t1 , 32 , error1 		# si tiene mas letras se manda un error
loop29:
	addi $t0 , $t0 , 1		# sumamos al contador 1
	lb $t1 , ($t0) 			# cargamoes el bit que esta en la posicon de t0
	bne $t1 , 32 , 	cls1		# saltamos si ya no hay mas espacios
	j loop29

cls1:	
	li $a0 , 1024			# cargamos la cantidad de memoria que necesitamos
	li $v0 , 9			# cargamos la intruccion de asignanar memoria
	syscall				# se asigna la memoria
	move $t4 , $v0			# guardamos la referencia a la memoria que acabamos de asignar
	move $t3 , $t0			# guardamos el inicio de la cadena
	move $t5 , $t4			# guardamos el inicio de la cadena
	beq $t1 , 10 , error1		# saltamos a crev4 si no hay archivo que leer

loop30:
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	beq $t1 , 46 , loop31		# saltamos hasta que encontramos un punto
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	j loop30			# saltamos al inicio del loop
	
loop31:
	addi $t0 , $t0 , 1		# nos movemos de caracter
	addi $t4 , $t4 , 1		# nos movemos de caracter
	lb $t1 , ($t0)			# cargamos el byte de la cadena 1
	beq $t1 , 32 , cls2		# saltamos hasta que encontramos un espacio 
	beq $t1 , 10 , cls2		# saltamos si encontramos un salto de linee
	sb $t1 , ($t4)			# guardamos el caracter en la memoria
	j loop31			# saltamos al inicio de loop

cls2:	
	sb $zero , ($t4)		# le ponemos al final de la cadena el caracter nulo
	move $a0 , $t5			# movemos el inicio de la cadena a a0
	li $a1 , 0			# bandera para abrir el archivo
	li $v0 , 13			# se carga la intruccion de abrir archivo
	syscall				# se abre el archivo
	beq $v0 , -1 , error2		# verificamos que se haya habierto el archivo
	move $t6 , $v0			# movemos el descriptor
	li $a0 , 1024			# cargamos la cantidad de memoria
	li $v0 , 9			# cargamos la intruccion de asignar memoria
	syscall				# se asigna la memoria
	move $t8 , $v0 			# guradamos la direccion de memoria
	move $s1 , $v0			# guardamos el inicio de la cadena

loop32: 
	move $t9 , $zero		# contador en 0
	move $a0 , $t6			# cargamos lo que estaba en a0
	la $a1 , buff2			# se le da el tamaño del buffer
	li $a2 , 5			# se carga el tamaño del texto
	blt $v0 , $a2 , cls3		# saltamos si leimos menos caracteres de los que deveriamos leer
	li $v0 , 14			# se carga la intruccion de Leer archivo
	syscall				# se lee archivo	
loop33:	
	blt  $v0 , $t9 , loop32		# salta si ya leiste todo el buffer
	lb $t7 , buff2($t9)		# cargamos el caracter
	sb $t7 , ($t8)			# gurdamos el caracter
	addi $t9 , $t9 , 1		# acumulador mas 1
	addi $t8 , $t8 , 1		# movemos al siguiente caracter
	j loop33			# se salta al inicio del ciclo
	
cls3:
	move $a0 , $t6			# movemos el descriptor denuevo a a0
	li $v0 , 16			# se carga la instruccion de cierre de archivo
	syscall				# se cierra el archivo				
	subi $t8 , $t8 , 1		# restamos uno a t8
loop34: beq $t8 , $s1 , inicio		# saltamos si terminamos de escribir el archivo 
	lb $a0 , ($s1)			# cargamos el caracter
	
	bne $a0 , 32 , else		# saltamos si t1 es un espacio en blanco
	li $a0 , 10 			# cargamos un salto de linea						
else:		
	li $v0 , 11			# cargamos la intruccion de imprimir caracter 
	syscall				# imprimimos el caracter
	addi $s1 , $s1 , 1		# contador mas 1
	j loop34								
										
											
	
