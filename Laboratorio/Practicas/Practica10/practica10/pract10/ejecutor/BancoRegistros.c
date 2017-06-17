#include "BancoRegistros.h"
#include "funcionesCadenas.h"

#include <stdlib.h>

/**
 * Representasión del banco de registros de la ALU. El cual contiene Registro A,
 * Registro B,  Write Register, Write Data.
 */
struct BancoRegistro{
	int Registro_A;
	int Registro_B;
	int escribir_registro;
	char *contenido_registro;
	char * registros[32];

};

/**
 * Nuevo banco de registros.
 * @return regresa un nuevo banco de registros. 
 */
BancoRegistro *nuevo_BR()
{
	BancoRegistro *nuevo_BancoRegistro = malloc(sizeof(BancoRegistro));
	return nuevo_BancoRegistro;
}

/**
 * Coloca un primer registro en un banco de registros.
 * @param primer registro a colocar.
 * @param banco en el que se colocara el primer registro.
 */
void setRegistroA(int registro , BancoRegistro * banco)
{
	banco->Registro_A = registro;
}

/**
 * Coloca un segundo registro en un banco de registros.
 * @param segundo registro a colocar.
 * @param banco en el que se colocara el segundo registro.
 */
void setRegistroB(int registro , BancoRegistro * banco)
{
	banco->Registro_B = registro;
}

/**
 * Escribe un registro en un banco de registros.
 * @param registro a escribir.
 * @param banco de registros correspondiente.
 */
void setEscribirRegistro(int registro , BancoRegistro * banco)
{
	banco->escribir_registro = registro;
}

void setRegistro(int num_registro , char *nvo_registro , BancoRegistro * banco)
{
	banco->registros[num_registro] = strclone(nvo_registro);
}

/**
 * Regresa el primer registro de un banco de registros.
 * @param banco de registros para obtener el primer registro.
 * @return Primer registro del banco de registros.
 */
int getRegistroA(BancoRegistro * banco)
{
	return banco->Registro_A;
}

/**
 * Regresa el segundo registro de un banco de registros.
 * @param banco de registros para obtener el segundo registro.
 * @return Segundo registro del banco de registros.
 */
int getRegistroB(BancoRegistro * banco)
{
	return banco->Registro_B;
}

/**
 * Regresa Write Register de un banco de registros.
 * @param banco de registro del que se devolvera.
 * @return Write Register.
 */
int getEscribirRegistro(BancoRegistro * banco)
{
	return banco->escribir_registro;
}

/**
 * Regresa un registro dado.
 * @param num_registro Identificador del registro.
 * @param banco Banco del registro.
 * @return registro que se solicito con el identificador.
 */
char* getRegistro(int num_registro , BancoRegistro * banco)
{
	return banco->registros[num_registro];
}

/**
 * Inicializa el banco de registros.
 * @param banco correspondiente.
 */
void InicializaRegistros(BancoRegistro * banco)
{
	char cadena0[33] = "00000000000000000000000000000000\0";
	int i;
	for( i = 0 ; i < 32 ; i++){
		banco->registros[i] = strclone(cadena0);
	}
}

/**
 * Libera el espacio de memoria del banco.
 * @param banco del que se liberara la memoria.
 */
void free_BR(BancoRegistro * banco)
{
	free(banco->contenido_registro);
	free(banco->registros);
	free(banco);
}
