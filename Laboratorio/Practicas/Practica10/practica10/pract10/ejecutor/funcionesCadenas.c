#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "funcionesCadenas.h"



/*
 * Convierte una cadena de caracteres a numeros entero decimal
 */
int stoi(char * str)
{
	int i;
	int size = strlen(str);
	int actual;
	int resultado = 0;
	for(i = 0; i < size ; i++){
		actual = (int)str[i] - 48;
		actual *= pow(10 , size-i-1);
		resultado += actual;
	}

	return resultado;
}

/*
 * clona una cadena para que no apunten a l amisma direcion de memoria
 * str es la cadena a clonar
 */
char *strclone(char *str)
{
  int str_size = strlen(str);
  char *ptnew_str;
  ptnew_str =malloc(str_size+1);
  strcpy(ptnew_str, str);
  return ptnew_str;
}

/**
 * Convierte de binario a decimal.
 * @param str Número a convertir.
 * @return Número decimal.
 */
int btoi(char * str)
{
	int longitud = strlen(str)-1;
	int exponente = 0;
	int resultado = 0;
	int actual;
	int es_negativo = 1;
	if(str[0] == 1){
		es_negativo = -1;
	}
	for( ; longitud >= 0 ; longitud-- ){
		if(str[longitud] != '0'){
			actual = pow(2,exponente);
			resultado += actual;
		}
		exponente++;

	}
	return (resultado * es_negativo);

}

/**
 * Convierte de decimal a binario.
 * @param number Numero a convertir.
 * @param num_digits Número de digitos.
 * @return  Numero en binario.
 */
char * itob(int number, int num_digits)
{
	char * numero_binario;
	numero_binario = malloc(num_digits*sizeof(char) +1);
	numero_binario[num_digits] = '\0';
	int es_negativo = 0;
	if(number < 0){
		es_negativo = 1;
	}
	num_digits --;
	while(number >= 0  && num_digits >= 0){
		if(number%2 == 0){
			numero_binario[num_digits] = '0';
		}else{
			numero_binario[num_digits] = '1';
		}
		num_digits--;
		number = number/2;
	}
	if(es_negativo){
		numero_binario[0] = '1';
	}else{
		numero_binario[0] = '0';
	}
	return numero_binario;
}

