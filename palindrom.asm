.data
slowo: .space 100
palindrom: .space 100
pytanie: .asciiz "\nPowtorzyc operacje? 0-nie 1-tak"
podaj: .asciiz "Podaj slowo"
odp1: .asciiz "To jest palindrom"
odp2: .asciiz "Nie jest to palindrom"



.text
main:

li $v0,4
la $a0,podaj
syscall

li $v0,8
la $a0,slowo
li $a1,100
syscall


add $t0,$zero,$zero			#Ustawia wartoœæ t0 na pewno na 0 
#addi $t0,$t0,0
while:
lb $t1,slowo($t0)
beq $t1,10,policzone		#Liczenie ile slowo ma liter
addi $t0,$t0,1
j while

policzone:
add $t6,$zero,$t0   #Rejestr w którym zawsze jest d³ugoœæ s³owa 
sb $zero,slowo($t6)
lw $t3,slowo

#addi $t2,$t2,0     # Index
add $t2,$zero,$zero #index
while2:
addi $t0,$t0,-1
beq $t0,-1,skok       #Jeœli index od koñca ten policzony wczesniej równy -1 to wyjdz 
lb $t1,slowo($t0)
sb $t1,palindrom($t2)
addi $t2,$t2,1		#Zwiêkszenie indexu do zapisu literki 
j while2
		


skok:

lw $t4,palindrom

beq $t3,$t4,rowny
li $v0,4
la $a0,odp2
syscall
j pytanieX
rowny:
li $v0,4
la $a0,odp1
syscall
					

pytanieX:
li $v0,4
la $a0,pytanie
syscall
li $v0,5
syscall
move $t5,$v0
beq $t5,1,pominexit
li $v0,10
syscall


pominexit:
addi $t5,$t5,-1    # index
while3:
add $t6,$t6,-1
beq $t6,-1,main
sb $zero,slowo($t6)
sb $zero,palindrom($t6)

    
j while3 
