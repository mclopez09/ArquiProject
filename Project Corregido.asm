	input $s0, 19, 0 #edad
	input $s1, 0, 1 #duraciondiclo
	input $s2, 3, 2 #diasultimezperiodo
	input $s3, 10, 3 #diasultimarelacion
	input $s4, 5, 4 #diasduracionperiodo
	input $s5, 0, 5 #planifica (1/0)
	input $s6, 1, 6 #estaperiodo (1/0)
	input 28, 7
	input 10, 8
	input 51, 9
	input 17, 10
	input 50, 11
	input 15, 12
	input 88, 13
	lw $r0, 1 #duracionciclo #proxperiodo
	beq $r0,0,Prox #Si la duracionciclo es igual a 0 salta a Prox	
	lw $r1, 2 #diasUltimaVezPeriodo
	sub $r3, $r0,$r1 #De lo contrario proxperiodo = duracionciclo - diasultimavezperiodo
	sw $r3, 80
	j PeriodoFertil
	
Prox:
	lw $r4, 7 #28
 	sub $r3,$r4,$r1 #Proximo periodo = 28 - diasultimavezperiodo
 	sw $r3, 80
 	
PeriodoFertil:

	bgtz $r0,DurCi #Si duracion ciclo es igual o menor a 0 salta a Durci
	lw $r5, 5 #planifica
	beq $r5,1,PeFer #Si planifica es 1 salta a PeFer
	lw $r6, 6 #estaperiodo
	beq $r6,1,PeFer2 # Si estaperiodo es 1 salta a PeFer2
	beq $r6,0,PeFer3 #Si estaPeriodo es igual a 0
	
PeFer3:
	lw $r3,8 
	bgt $r1,$r3,PeFer4 #Si r6 = 0 y diasUltimaVez > 10
	blt $r1,$r3,PeFer6 #Si r6 = 0 y diasUltimaVez < 10
	lw $r3,10
	bge $r1,$r3,PeFer7 #Si r6 = 0 y diasUltimaVez >= 17

PeFer4:
	lw $r3,10
	blt $r1,17,PeFer5 #Si S6 = 0 y S2 > 10 y S2 < 17
	j PeFer7

PeFer5:
	sub $r3, $r3, $r3 # volver $r3 a 0
	addi $r3,$r3,1 #Esta en su periodo fertil
	sw $r3, 81
	j Menopausia
	

PeFer6:
	lw $r3, 8
	addi $r3,$r3,$r1 #faltan t1 dias para su periodo fertil
	sw $r3, 81
	j Menopausia

PeFer7:
	sub $r3,$r0,$r1 #Duracionciclo-DiasUltimaVez
	lw $r7, 4 #diasduracionPeriodo
	add $r3,$r3,$r7 #(Duracionciclo-DiasUltimaVez)+diasDuracionPeriodo
	addi $r3,$r3,7  #((S1+S2)+S4)+7
	sw $r3, 81
	j Menopausia
	
PeFer2:
	sub $r3, $r3, $r3 # volver $r3 a 0
	lw $r7, 4 #diasduracionPeriodo
	sub $r3,$r7,$r1 # Perfe = diasduracionperiodo - diasultimavezPeriodo
	addi $r3,$r3,7 # Perfe = Perfe + 7
	sw $r3, 81
	j Menopausia

PeFer:
	sub $r3, $r3, $r3 # volver $r3 a 0
	addi $r3,$0,0 #No tendrÃ¡ periodo fertil
	sw $r3, 81
	j Menopausia

DurCi:
	addi $r0,$0,28 #Duracion ciclo tendrÃ¡ un promedio de 28 dias 
	sw $r0, 1
	j PeriodoFertil

Menopausia:
	lw r4, 0 #edad
	bgt $r4,50,meno2 #Si la edad es mayor a 50 salta a meno2
	lw $r3, 9
	sub $r7, $r7, $r7 # volver $r7 a 0
	addi $r7,$r3,$r4 #Años faltantes para tener menopausia
	sw $r7, 82
	j Alertas

meno2:
	addi $r7,$0,1 #Se le asigna uno porque esta prox a la menopausia
	sw $r7, 82

Alertas:
	blez $r0,Alerta2 #Si duracion ciclo es igual a 0 salta a Alerta2
	lw $r7, 4 #diasDuracionPeriodo
	add $r3,$r0,$r7 #Suma duracionCiclo + diasDuracionPeriodo de la condicion
	addi $r3,$r3,7 #Suma el resultado anterior mas 7 de la condición
	bge $r1,$r3,Alerta3 #Compara si diasUltimaVez >= (duracionCiclo + diasDuracionPeriodo + 7) se cumple y salta a Alerta3
	j Alerta6
	
 Alerta3:
 	beq $r5,0,Alerta4 #Si no planifica salta a Alerta4 a revisar la ultima condicion
 	j Alerta6
 		
 Alerta4:
 	lw $r3 ,3
 	blt $r3,15,Alerta5 #Si los dias de la ultima relacion son menores que 15 salta a Alerta5 porque se cumple la ultima condicion
 	j Alerta6
 		
 Alerta2:
 	addi $r0,$0,28 #Duracion ciclo tendrÃ¡ un promedio de 28 dias
 	sw $r0, 1 
	j Alertas
 	
Alerta5:
	sub $r7, $r7, $r7 # volver $r7 a 0 #0 debido a que activa alerta de embarazo
	sw $r7,83	
 	j Fin
 	
Alerta6:
	bgt $r1,88, Alerta7
	sub $r7, $r7, $r7 # volver $r7
	addi $r7,$0,2 #2 debido a que no activa ninguna alerta
	sw $r7, 83
	j Fin
	
Alerta7:
	sub $r7, $r7, $r7 # volver $r7
	addi $r7,$0,1 #1 debido a que activa alerta de retraso
	sw $r7, 83

 	
Fin:	