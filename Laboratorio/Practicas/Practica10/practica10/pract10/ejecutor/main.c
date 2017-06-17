#include <stdio.h>
#include <string.h>

#include "FlujoDatos.h"

/*
 * esta es el carchivo ejecutable
 */

int main()
{
	char nombre_archivo[40] ="";
	printf("Escriba a continuacion el nombre del archivo objeto: \n");
	scanf("%s", nombre_archivo);
	FILE *fichero;
	fichero = fopen(nombre_archivo , "r");
	if( fichero ){


		LlenaMemoria(fichero);
		if( fclose(fichero) ){
			printf( "Error: archivo objeto NO CERRADO\n" );
		}

		RutaDeDatos();
		FILE * fichero_texto;
		FILE * fichero_datos;
		fichero_texto = fopen("registros.txt" , "w+");
		fichero_datos = fopen("memoria de datos.txt" , "w+");
		EscribeArchivos(fichero_texto , fichero_datos);
		freeElementos();

	}else{
		printf( "Error (NO ABIERTO)\n" );
		return 1;
	}
}
