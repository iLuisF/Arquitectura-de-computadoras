#if !defined(NULL)
#define NULL 0
#endif

typedef struct BancoRegistro BancoRegistro;

BancoRegistro *nuevo_BR();
void setRegistroA(int registro , BancoRegistro * banco);
void setRegistroB(int registro , BancoRegistro * banco);
void setEscribirRegistro(int registro , BancoRegistro * banco);
void setRegistro(int num_registro , char *nvo_registro , BancoRegistro * banco);
void InicializaRegistros(BancoRegistro * banco);
int getRegistroA(BancoRegistro * banco);
int getRegistroB(BancoRegistro * banco);
int getEscribirRegistro(BancoRegistro * banco);
char* getRegistro(int num_registro , BancoRegistro * banco);
void free_BR(BancoRegistro * banco);
