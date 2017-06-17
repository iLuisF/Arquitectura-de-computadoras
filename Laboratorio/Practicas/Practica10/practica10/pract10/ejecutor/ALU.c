#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "funcionesCadenas.h"
#include "ALU.h"

/**
 * ALU que contiene dos registros, además de indicar la operación con un entero.
 */
struct ALU{
	char *Registro_A;
	char *Registro_B;
	int operacion;
};

char *OR(char *str1 , char *str2);
char *AND(char *str1 , char *str2);
char *ADD(char *str1 , char *str2);
char *SUB(char *str1 , char *str2);
char *getALURegistroA(ALU *ALU);
char *getALURegistroB(ALU *ALU);

/**
 * Regresa una nueva ALU.
 * @return Nueva ALU.
 */
ALU *nueva_ALU(){
	ALU *nueva_ALU = malloc(sizeof(ALU));
	return nueva_ALU;
}

/**
 * Coloca el primer registro en la ALU.
 * @param registro dirección para ser colocado en la ALU.
 * @param ALU dirreción para colocar el registro.
 */
void setALURegistroA(char * registro , ALU* ALU)
{
	ALU->Registro_A = strclone(registro);
}

/**
 * Coloca el segundo registro en la ALU.
 * @param registro dirección para ser colocado en la ALU.
 * @param ALU dirreción para colocar el registro.
 */
void setALURegistroB(char * registro , ALU* ALU)
{
	ALU->Registro_B = strclone(registro);
}

/**
 * Coloca la operación a realizar.
 * @param operacion a realizar.
 * @param ALU dirección para colocar la operación.
 */
void setALUOperacion(int operacion , ALU* ALU)
{
	ALU->operacion = operacion;
}

/**
 * Regresa la operación correspondiente de la ALU.
 * @param ALU de donde se devolvera la operación.
 * @return Operación correspondiente de la ALU.
 */
int getALUOperacion(ALU * ALU)
{
	return ALU->operacion;
}

/**
 * Regresa el contenido del registro A.
 * @param ALU correspondiente.
 * @return contenido del registro A.
 */
char *getALURegistroA(ALU *ALU){
	return ALU->Registro_A;
}

/**
 * Regresa el contenido del registro B.
 * @param ALU correspondiente.
 * @return Contenido del registro B.
 */
char *getALURegistroB(ALU *ALU){
	return ALU->Registro_B;
}

/**
 * Realiza una operación de la ALU. Tal como sumar, restar, and, or.
 * @param ALU correspondiente.
 * @return el resultado de la operación.
 */
char *RealizaOperacion(ALU *ALU){
	char*resultado = NULL;
	switch(getALUOperacion(ALU)){
	case 1:
	case 2:
	case 3:
	case 4:
	case 5:
	case 6:
	case 7:
	case 14:
		resultado = ADD(getALURegistroA(ALU) , getALURegistroB(ALU));
		break;

	case 8:
	case 15:
		resultado = SUB(getALURegistroA(ALU) , getALURegistroB(ALU));
		break;

	case 9:
	case 16:
		resultado = AND(getALURegistroA(ALU) , getALURegistroB(ALU));
		break;

	case 10:
	case 17:
		resultado = OR(getALURegistroA(ALU) , getALURegistroB(ALU));
		break;

	}
	return resultado;
}

/**
 * Realiza la operación or.
 * @param str1 primer argumento a comparar.
 * @param str2 segundo argumento a comparar.
 * @return resultado de la comparacion.
 */
char *OR(char *str1 , char *str2)
{
	char * resultado = malloc(33*sizeof(char));
	int i;
	for( i = 0 ; i < 32	; i++){
		if(str1[i] == '1' || str2[i] == '1'){
			resultado[i] = '1';
		}else{
			resultado[i] = '0';
		}
	}
	resultado[32] = '\0';
	return resultado;
}

/**
 * Realiza la operación and.
 * @param str1 primer argumento a comparar.
 * @param str2 segunda argumento a comparar.
 * @return resultado de la comparación.
 */
char *AND(char *str1 , char *str2)
{
	char * resultado = malloc(33*sizeof(char));
	int i;
	for( i = 0 ; i < 32	; i++){
		if(str1[i] == '1' && str2[i] == '1'){
			resultado[i] = '1';
		}else{
			resultado[i] = '0';
		}
	}
	resultado[32] = '\0';
	return resultado;
}

/**
 * Realiza una suma de dos cadenas.
 * @param str1 primer cadena(numero).
 * @param str2 segunda cadena(numero).
 * @return resultado de la suma.
 */
char *ADD(char *str1 , char *str2)
{
	char * resultado;
	int num_str1= btoi(str1);
	int num_str2= btoi(str2);
	resultado = itob((num_str1 + num_str2) , 32);
	return resultado;
}

/**
 * Realiza un resta de dos numeros(cadenas).
 * @param str1 cadena 1. 
 * @param str2 cadena 2.
 * @return Resultado de la resta.
 */
char *SUB(char *str1 , char *str2)
{
	char * resultado;
	int num_str1= btoi(str1);
	int num_str2= btoi(str2);
	resultado = itob((num_str1 - num_str2) , 32);
	return resultado;
}

/*
 * Libera la memoria correspondiente a la ALU.
 */
void free_ALU(ALU* ALU)
{
	free(getALURegistroA(ALU));
	free(getALURegistroB(ALU));
	free(ALU);
}







