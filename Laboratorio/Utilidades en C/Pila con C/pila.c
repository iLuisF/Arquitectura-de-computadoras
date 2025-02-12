#include "pila.h"
#include <stdio.h>

//Constructor.

pila * new_pila(int size){
  pila * p;
  p = malloc(sizeof(struct pila));
  p->content = calloc(size, sizeof(int));
  //atributos
  p->size = size;
  p->index = 0;
  p->push = pila_push; //Esto los relaciona con Pila.h
  p->pop = pila_pop; //
  return p;
}

//implementacion de metodos.
void pila_push(pila * this, int val){
  if(this->index < this->size){
    this->content[this->index] = val;
    this->index ++;
  }else{
    printf("La pila esta llena\n");
  }
}

int pila_pop(pila * this){
  int valor = 0;
  if(this->index > 0){
    this->index--;
    valor = this->content[this->index];
    this->content[this->index] = 0;
  }else{
    printf("La pila esta vacia..\n");
  }
  return valor;
}
