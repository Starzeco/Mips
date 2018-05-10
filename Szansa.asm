.data
pytanie0: .asciiz "Co ma siê wykonaæ? 0-szyfrowanie/1-deszyfrowanie"
pytanie: .asciiz "Podaj klucz: "
pytanie2: .asciiz "Podaj wyrazenie: "
klucz: .space 100
s³owo: .space 100


.text
main:

li $v0,4
la $a0,pytanie0
syscall			#W³adowanie pytania o operacje

li $v0,5
syscall
add $t9,$zero,$v0
beq $t9,0,szyfrowanie
beq $t9,1,deszyfrowanie



szyfrowanie:
li $v0,4
la $a0,pytanie
syscall  #W³adowanie pytania

li $v0,8
la $a0,klucz
li $a1,100    # Pobranie klucza i wsadzenie go do pamiêci 
syscall

li $v0,4
la $a0,pytanie2
syscall		# W³adowanie pytania 2

li $v0,8
la $a0,s³owo
li $a1,100
syscall  	# Pobranie s³owa i zapisanie go w pamiêci 


# SZYFROWANIE 

addi $t0,$t0,0	  #index
addi $t8,$t8,26  #Rejestr do dzielenia modulo
while:
lb $t1,klucz($t0)	# Rejestr w którym jest odpowiedni byte
lb $t2,s³owo($t0)	# to samo tylko ¿e dla s³owa

beq $t1,10,exit		#Jeœli byte równy null to wyjdŸ
beq $t2,0,exit

addi $t0,$t0,1		#Dodanie jedynki do indexu

addi $t1,$t1,-97	# Wykonanie szyfrowania 
addi $t2,$t2,-97
add $t3,$t1,$t2	
blt $t3,26,bezmodulo	

div $t3,$t8		# Dzielenie modulo 
mfhi $t3
bezmodulo:		#Wyjêcie wyniku modulo i wsadzenie do t
addi $t3,$t3,97


li $v0,11		#Wyœwietlenie zaszyfrowanej litery
add $a0,$zero,$t3
syscall
j while

exit:
li $v0,10
syscall

deszyfrowanie:
li $v0,4
la $a0,pytanie
syscall  #W³adowanie pytania

li $v0,8
la $a0,klucz
li $a1,100    # Pobranie klucza i wsadzenie go do pamiêci 
syscall

li $v0,4
la $a0,pytanie2
syscall		# W³adowanie pytania 2

li $v0,8
la $a0,s³owo
li $a1,100
syscall  	# Pobranie s³owa i zapisanie go w pamiêci 

addi $t4,$t4,0	#index
while2:
lb $t5,klucz($t4)	# Rejestr w którym jest odpowiedni byte
lb $t6,s³owo($t4)	# to samo tylko ¿e dla s³owa

beq $t5,10,exit		#Jak koniec to exit xD

addi $t4,$t4,1		#Zwiekszenie indexu

addi $t5,$t5,-97	# Wykonanie deszyfrowania 
addi $t6,$t6,-97

blt $t6,$t5,skok	#Jeœli s³owo jest mniejsze odklucza to wynik odejmowania bêdzie ujemny i trzeba inaczej postêpowac
sub $t7,$t6,$t5
addi,$t7,$t7,97
j wyswietlenie 
 
skok:  
sub $t7,$t6,$t5
addi $t7,$t7,123
j wyswietlenie

wyswietlenie:
li $v0,11		#Wyœwietlenie zaszyfrowanej litery
add $a0,$zero,$t7
syscall
j while2
