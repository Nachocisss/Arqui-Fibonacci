.data 
texto: .asciiz "\n resultado de fibonacci: "
pedir: .asciiz "\n ingrese numero: "
error: .asciiz "\n 0 no es una posicion valida"

.text

main: 
	li $t0,0  #a
	li $t1,1  #b
	li $t2,1  #z

	la $a0, pedir #texto que pide ingresar numero
	li $v0 , 4
	syscall
	li $v0, 5  # guarda el numero pedido en v0
	syscall
	move $t3, $v0 #lo movemos a t3, pasa a ser el n

	li $t4,1  
	li $t5,1 #contador del loop
	beq $t3, $zero, cero #comprueba si es 0 el n
	beq $t3,$t4,uno #comprueba si es 1 el n
	addi $t3, $t3, -1  #reduce en 1 el n

loop: 
	beq $t5,$t3,end #realiza el loop hasta llegar a n
	add $t2,$t0,$t1 #suma de los dos numeros anteriores se guarda en z
	add $t0, $t1, $zero #cambiamos a por el b
	add $t1, $t2, $zero #cambiamos b por el nuevo z
	addi $t5,$t5,1  #aumenta el contador en 1
	j loop
	
uno: 
	li $t2,0 #se asigna 0 si el n es 1
	j end

cero:
	la $a0, error # texto de error
	li $v0 , 4
	syscall
	j exit

end:
	la $a0, texto # texto de resultado
	li $v0 , 4
	syscall
	move $a0, $t2
	li $v0, 1   # imprime el resultado
	syscall

exit:
	li $v0 10  #termina el programa
	syscall 
