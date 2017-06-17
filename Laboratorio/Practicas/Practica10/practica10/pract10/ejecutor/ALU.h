#if !defined(NULL)
#define NULL 0
#endif

typedef struct ALU ALU;

ALU *nueva_ALU();
void setALURegistroA(char * registro , ALU* ALU);
void setALURegistroB(char * registro , ALU* ALU);
void setALUOperacion(int operacion , ALU* ALU);
int getALUOperacion(ALU * ALU);
char *RealizaOperacion(ALU *ALU);
void free_ALU(ALU* ALU);
