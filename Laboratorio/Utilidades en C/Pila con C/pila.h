//Header de la pila, es decir, su definición.

//Definición del objeto/estructura.
typedef struct pila pila;

struct pila{
  int size; //Tamaño de la pila.
  int index; //Indice de la pila.
  int * content; //Contenido como un puntero de tipo int.
  //metodos
  //void = tipo de la función. push = puntero a la función.
  void (* push)(pila * this, int val);
  int (* pop)(pila * this);
};

//Definicion de los metodos.
void pila_push(pila * this, int val);
int pila_pop(pila * this);

//constructor
pila * new_pila(int size);
