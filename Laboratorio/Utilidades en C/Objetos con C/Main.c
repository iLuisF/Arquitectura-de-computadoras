#include <stdlib.h>
//Importamos las implementaciones ya hechas para poderlas usar.
#include "Carro.c" 


/**
 * Probamos las implementaciones creando un carro, imprimiendo el kilometraje,
 * el número de puertas y cuando se prende.
 */
int main(){

	//Se crea un carro del modelo Versa con 4 puertas, se pueden crear varios modelos para 
	//reusar lo que ya hicimos.
	Carro* versa = nuevoCarro(4);

	versa->setKm(versa, 50350); //Se asigna el kilometraje
	printf("El kilometraje es: %d\n", versa->getKm(versa));	
	printf("El número de puertas es: %d\n",  versa->puertas); 
	printf("El número de puertas(con diferente acceso) es: %d\n", versa->getPuertas(versa));
	versa->prenderCarro(versa);
	versa->eliminarCarro(versa); //Se libera el espacio en memoria.
}