	input 19, 0 #edad
	input 0, 1 #duraciondiclo
	input 3, 2 #diasultimezperiodo
	input 10, 3 #diasultimarelacion
	input 5, 4 #diasduracionperiodo
	input 0, 5 #planifica (1/0)
	input 1, 6 #estaperiodo (1/0)
Proxperiodo:
	lw $r0, 1 #duracionciclo
	beq $r0,0,Prox #Si la duracionciclo es igual a 0 salta a Prox	
	lw $r1, 2 #diasUltimaVezPeriodo
	sub $r3, $r0,$r1 #De lo contrario proxperiodo = duracionciclo - diasultimavezperiodo
	sw $r3, 32
	j PeriodoFertil
	
Prox:
	lw $r4, 7 #28
 	sub $r3,$r4,$r1 #Proximo periodo = 28 - diasultimavezperiodo
 	sw $r3, 32
 	
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
	addi $r3,$0,1 #Esta en su periodo fertil
	sw $r3, 33
	j Menopausia
	

PeFer6:
	lw $r3, 8
	addi $r3,$r3,$r1 #faltan t1 dias para su periodo fertil
	sw $r3, 33
	j Menopausia

PeFer7:
	sub $r3,$r0,$r1 #Duracionciclo-DiasUltimaVez
	lw $r7, 4 #diasduracionPeriodo
	add $r3,$r3,$r7 #(Duracionciclo-DiasUltimaVez)+diasDuracionPeriodo
	addi $r3,$r3,7  #((S1+S2)+S4)+7
	sw $r3, 33
	j Menopausia
	
PeFer2:
	lw $r7, 4 #diasduracionPeriodo
	sub $r3,$r7,$r1 # Perfe = diasduracionperiodo - diasultimavezPeriodo
	addi $r3,$r3,7 # Perfe = Perfe + 7
	sw $r3, 33
	j Menopausia

PeFer:
	sw $0, 33 ###no tendra periodo fertil
	j Menopausia

DurCi:
	lw $r0 ,7 #Duracion ciclo tendrÃ¡ un promedio de 28 dias 
	sw $r0, 1
	j PeriodoFertil

Menopausia:
	lw $r4, 0 #edad
	lw $r3, 11 #50
	bgt $r4,$r3,meno2 #Si la edad es mayor a 50 salta a meno2
	lw $r3, 9
	add $r7,$r3,$r4 #Años faltantes para tener menopausia
	sw $r7, 34
	j Alertas

meno2:
	addi $r7,$0,1 #Se le asigna uno porque esta prox a la menopausia
	sw $r7, 34

Alertas:
	blez $r0,Alerta2 #Si duracion ciclo es igual a 0 salta a Alerta2
	lw $r7, 4 #diasDuracionPeriodo
	add $r3,$r0,$r7 #Suma duracionCiclo + diasDuracionPeriodo de la condicion
	addi $r3,$r3,7 #Suma el resultado anterior mas 7 de la condición
	bge $r1,$r3,Alerta3 #Compara si diasUltimaVez >= (duracionCiclo + diasDuracionPeriodo + 7) se cumple y salta a Alerta3
	j Alerta6
	
 Alerta3:
 	beq $r5,$0,Alerta4 #Si no planifica salta a Alerta4 a revisar la ultima condicion
 	j Alerta6
 		
 Alerta4:
 	lw $r3 ,3
 	lw $r7, 12
 	blt $r3,$r7,Alerta5 #Si los dias de la ultima relacion son menores que 15 salta a Alerta5 porque se cumple la ultima condicion
 	j Alerta6
 		
 Alerta2:
 	lw $r0,7 #Duracion ciclo tendrÃ¡ un promedio de 28 dias
 	sw $r0, 1 
	j Alertas
 	
Alerta5:
	sw $0,35	
 	j Fin
 	
Alerta6:
	lw $r3, 13
	bgt $r1,$r3, Alerta7
	addi $r7,$0,2 #2 debido a que no activa ninguna alerta
	sw $r7, 35
	sw $r7, 36
	j Fin
	
Alerta7:
	addi $r7,$0,1 #1 debido a que activa alerta de retraso
	sw $r7, 36	
Fin:	