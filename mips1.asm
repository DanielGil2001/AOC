.data 
Cero: .float 2.0
Uno: .float 1.0

.text
main:
	la $t0, Cero
	lwc1 $f1, 0($t0)
	
	li $v0,6 
	syscall #pedimos limite inferior 
	mov.s $f12,$f0
	
	
	syscall	#pedimos limite superior
	mov.s $f13, $f0
	
	
	syscall #pedimos cota del error
	mov.s $f14,$f0
	
	jal Bisec
	
	li $v0,10
	syscall
Funcion: #funcion a libre elección
	mul.s $f0,$f16,$f16
	jr $ra
	
Bisec: #funcion a construir
	
	#restamos 4 a la pila y guardamos la dirección de retorno del main en la pila
	addi $sp,$sp -4
	sw $ra,0($sp)
	
	
	mov.s $f16, $f12
	jal Funcion
	mov.s $f20,$f0
	
	mov.s $f16, $f13
	jal Funcion
	mov.s $f21,$f0
	
	
	
	
	
	
	#cargamos la dirección de retorno del main de la pila a %ra y sumamos 4 a la pila
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	
	
	jr $ra