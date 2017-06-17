//Ya hicimos la definición ahora tenemos que hacer la implementación.

//Importamos la cabecera para implementar las definiciones.
#include "Carro.h" 
#include <stdio.h>

/**
 * Constructor para un nuevo carro.
 * puertas - Número de puertas.
 */
Carro* nuevoCarro(int puertas){
	Carro* nuevo;//Necesitamos un carro.
	nuevo = malloc(sizeof(struct Carro)); //Reservamos espacio para el carro.	
	nuevo->puertas = puertas; //Atributo del número de puertas.
	//Métodos que se relacionaran con la implementación y la definición.
	nuevo->getPuertas = get_Puertas; 
	nuevo->getKm = get_Km;	
	nuevo->setKm = set_Km;
	nuevo->prenderCarro = prender_Carro;		
	nuevo->eliminarCarro = eliminar_Carro;
	return nuevo;
}

/**
 * Libera el espacio en memoria que fue usado al crear el carro.
 */
void eliminar_Carro(Carro* this){
	free(this);
}

/**
 * Regresa el número de puertas de un carro.
 */
int get_Puertas(Carro* this){
	int valor =  0;
	valor = this->puertas;
	return valor;
}

/**
 * Regresa el número de kilometros de un carro.
 */
int get_Km(Carro* this){
	int valor = 0;
	valor = this->km;
	return valor;
}

/**
 * Asigna el número de kilometros de un carro.
 */
void set_Km(Carro* this, int km){
	this->km = km;
}

/**
 * Imprime en pantalla que se prendio el carro.
 */
void prender_Carro(Carro* this){
	printf("El carro esta prendido\n");	
}


