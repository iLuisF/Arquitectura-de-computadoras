	.data
a:	.word	12
b:	.word	10
	.text
et:	lw	$01, a
	sw 	$01, b
	j	et
	
