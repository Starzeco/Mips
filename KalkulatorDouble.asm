.data
a: .asciiz "\nPodaj wartosc pierwszego arugmentu"
s: .asciiz "Jakie dzialanie ma sie wykonac 0-dodawanie/1-odejmowanie/2-dzielenie/3-mnozenie"
c: .asciiz "Podaj wartosc drugiego argumentu"
d: .asciiz "\nCzy wykonac kolejna operacje 1-TAK/0-NIE"
w: .asciiz "Wynik to:"

.text
main:

li $v0,4
la $a0,a
syscall

li $v0,7
syscall

mov.d $f2,$f0		# Pierwszy argument jest w f2 i f3 

li $v0,4
la $a0,s
syscall

li $v0,5
syscall

add $t0,$zero,$v0	# w rejestrze t0 informacja o tym jakie dzialanie ma sie wykonac

li $v0,4
la $a0,c
syscall

li $v0,7
syscall

mov.d $f4,$f0 		#Drugi argument jest w f4 i f5

beq $t0,0,dodawanie 	#Jeœli liczba zczytana c zapytania c równa 0 to skocz do label'u dodawanie 
beq $t0,1,odejmowanie	#Jeœli liczba zczytana c zapytania c równa 1 to skocz do label'u odejmowanie
beq $t0,2,dzielenie	#Jeœli liczba zczytana c zapytania c równa 2 to skocz do label'u dzielenie
beq $t0,3,mnozenie	#Jeœli liczba zczytana c zapytania c równa 3 to skocz do label'u mno¿enie

dodawanie:
add.d $f12,$f2,$f4

li $v0,4
la $a0,w
syscall

li $v0,3
syscall

j zapytanie

odejmowanie:
sub.d $f12,$f2,$f4

li $v0,4
la $a0,w
syscall

li $v0,3
syscall

j zapytanie

dzielenie:
div.d $f12,$f2,$f4

li $v0,4
la $a0,w
syscall

li $v0,3
syscall

j zapytanie


mnozenie:
mul.d $f12,$f2,$f4

li $v0,4
la $a0,w
syscall

li $v0,3
syscall

j zapytanie




zapytanie:
li $v0,4
la $a0,d
syscall

li $v0,5
syscall

add $t1,$zero,$v0
beq $t1,1,main

li $v0,10
syscall

