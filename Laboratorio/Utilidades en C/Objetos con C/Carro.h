//Se crea un header de Carro, es decir, definimos el objeto Carro.

//Definimos struct Carro como Carro
typedef struct Carro Carro;

/**
* Las acciones que realizara el carro, sus atributos y los métodos
* de acceso.
*/
struct Carro{
	int km; //Kilometros del carro
	int puertas; //Puertas del carro.
	//Los métodos, pero como en C no se pueden hacer funciones dentro de una estructura
	//usaremos punteros hacía funciones.
	//El parametro "Carro * this", se refiere al objeto para modificar su propiedades.
	int (*getPuertas)(Carro* this);
	int (*getKm)(Carro* this);
	void (*setKm)(Carro* this, int km);	
	void (*prenderCarro)(Carro* this);
	void (*eliminarCarro)(Carro* this);
};

//Definimos los métodos que implementaremos más tarde.
int get_Puertas(Carro* this);
int get_Km(Carro* this);
void set_Km(Carro* this, int km);
void prender_Carro(Carro* this);
void eliminar_Carro(Carro* this);

//Definimos el constructor.
Carro* nuevoCarro(int puertas);