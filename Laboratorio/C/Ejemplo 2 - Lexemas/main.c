#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "queue.h"

static const int LINE_MAX = 100; // Número máximo de caracteres en un lexema.

char *strclone(char *str);
queue *lexemas(const char *file);
char *itob(int number, int num_digits);

/*
 * Regresa una copia de la cadena str.
 */
char *strclone(char *str){
  int str_size = strlen(str);
  char *ptnew_str;
  ptnew_str = malloc(str_size + 1);
  strcpy(ptnew_str, str);
  return ptnew_str;
}

/*
 * Regresa una cadena de caracteres con el number codificado en 
 * binario a num_digits dígitos.
 */
char *itob(int number, int num_digits)
{
  char *ptdigit;
  ptdigit = malloc(num_digits + 1);
  *(ptdigit + num_digits + 1) = '\0';
  while (number > 0 && num_digits >= 0) {
    *(ptdigit + num_digits--) = (number % 2) ? '1': '0'; // Línea muy abusiva de la sintaxis
    number /= 2;
  }
  while (num_digits >= 0) 
    *(ptdigit + num_digits--) = '0';
  return ptdigit;
}

/*
 * Regresa una cola con los lexemas del archivo file.
 */
queue *lexemas(const char *file)
{
  FILE *ptfile;             // Archivo a leer
  ptfile = fopen(file, "r");
  queue *q;                 // Cola para los lexemas
  q = new_queue();
  char char_read = 0;       // Caracter leido
  int numchar_read = 0;     // Contador del número de carcateres leidos del lexema
  char lexema[LINE_MAX];    // Buffer para ir guardando el lexema que se está leyendo
  int continue_reading = 1; // Indica si se debe continuar leyendo el archivo
  if (ptfile == NULL){ // Falló lectura de archivo
    free(q);
    q = NULL;
    continue_reading = 0;
  } 
  while (continue_reading) {
    char_read = fgetc(ptfile);
    switch (char_read) {
    case EOF:
      continue_reading = 0;
    case '\n':     
      // TODO contar líneas, no contar líneas vacías ni de  directivas data y text.
    case ' ': 
    case '\t':
      if (numchar_read > 0){ // Fin de lexema, guardar lexema y reiniciar contador
	lexema[numchar_read] = '\0';
	enqueue(strclone(lexema), q);
	numchar_read = 0;
      }
      break;
    case ':': 
      // TODO Guardar etiqueta en tabla, la etiqueta NO se guarda en la cola.
    case ',':
      if (numchar_read > 0) { // Fin de lexema, guardar lexema y reiniciar contador
	lexema[numchar_read] = '\0';
	enqueue(strclone(lexema), q);
	numchar_read = 0;
      }
      lexema[0] = char_read; // Guardar ','
      lexema[1] = '\0';
      enqueue(strclone(lexema), q);
      break;
    case '.':
      // TODO Sigue una directiva, no contar línea si es .data o .text
    default:
      lexema[numchar_read++] = char_read;
    }
  }
  fclose(ptfile); // ¡Siempre cierren el archivo!
  return q;
}

int main(int argc, char **argv)
{
  if (argc != 2) {
    printf("Se esperaba el nombre del archivo a ensamblar.\n");
    exit(1);
  }
  queue *q;
  q = lexemas(*(argv + 1));
  if (q == NULL) {
    printf("Archivo %s no encontrado.\n", *(argv + 1));
    exit(1);
  }
  printf("Los lexemas del archivo %s son:\n", *(argv + 1));
  char *lex;
  while (size(q) > 0) {
    lex =  dequeue(q);
    printf("%s\n", lex);
    free(lex); // ¡Siempre liberen memoria que ya no se va a usar!
  }
  free(q); // ¡Siempre liberen memoria que ya no se va a usar!
  
  int i;
  char *num;
  printf("\nPrueba de conversión a binario:\n");
  for (i = 0; i < 9; i++) {
    num = itob(i,2);
    printf("%d = %s\n", i, num);
    free(num); // ¡Siempre liberen memoria que ya no se va a usar!
  }
}
