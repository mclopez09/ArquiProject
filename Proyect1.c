
#include <stdio.h>
#include <stdlib.h>


int ProximoPeriodo(diasUltimaVez, duracionCiclo){
	//Función para conocer el dia del proximo periodo de menstruación
	int prox;
	if (duracionCiclo == 0){
		prox = 28 - diasUltimaVez;
	}
	else{
		prox =  duracionCiclo - diasUltimaVez;
	}
	printf("%d\n",prox );
	return prox;
}

int PeriodoFertil(diasDuracionPeriodo, diasUltimaVez, duracionCiclo, Estaperiodo, planifica){
	//Función para conocer el dia del proximo periodo fertil
	int perFe;
	if (duracionCiclo == 0){
		duracionCiclo = 28;
	}
	if (planifica == 1){
		printf("%d\n",0);
		return 0; //No tiene periodo fertil.
		}else if(Estaperiodo == 1){
			perFe = (diasDuracionPeriodo - diasUltimaVez) + 7;
		}	
		else if (Estaperiodo == 0 && diasUltimaVez > 10 && diasUltimaVez < 17){
			printf("%d\n",1);
			return 1; //Está en el periodo fertil. 
		}	
		else if(Estaperiodo == 0 && diasUltimaVez < 10){
			perFe = 10 - diasUltimaVez;
		}
		else if (Estaperiodo == 0 && diasUltimaVez >= 17){
			perFe = (duracionCiclo - diasUltimaVez) + (diasDuracionPeriodo + 7)  ;
		}
	printf("%d\n",perFe );
	return perFe;
}

int Menopausia (edad){
	int anosmeno;
	if (edad > 50){
		printf("%d\n",0);
		return 0;
	}else{
		anosmeno = 51-edad;
	}
	printf("%d\n", anosmeno);
	return anosmeno;
}

int Alertas(Estaperiodo, diasUltimaVez, duracionCiclo, planifica, diasultimaRelacion, diasDuracionPeriodo){
	// 0 - alertaembarazo;
	// 1 - alertatraso;
	// 2 - no alerta;
	if (duracionCiclo == 0){
		duracionCiclo = 28;
	}
	if (diasUltimaVez >= (duracionCiclo + diasDuracionPeriodo + 7) && planifica == 0 && diasultimaRelacion < 15){
		printf("%d\n",0);
		return 0;
	}
	if (diasUltimaVez > 88){
		printf("%d\n",1);
		return 1;
	}
	printf("%d\n",2);
	return 2;
} 
int main(){

	int edad = 19;
	int duracionCiclo = 25;
	int diasUltimaVez = 3;
	int diasultimaRelacion = 10;
	int diasDuracionPeriodo = 5;
	int planifica = 0;
	int Estaperiodo = 1;
	ProximoPeriodo(diasUltimaVez, duracionCiclo);
	PeriodoFertil(diasDuracionPeriodo, diasUltimaVez, duracionCiclo, Estaperiodo, planifica);
	Menopausia(edad);
	Alertas(Estaperiodo, diasUltimaVez, duracionCiclo, planifica, diasultimaRelacion, diasDuracionPeriodo);
}