#if !defined(NULL)
#define NULL 0
#endif

typedef struct UnidadControl UnidadControl;

UnidadControl* nueva_UC();
void setRegWrite(int opcion , UnidadControl* UC);
void setALUsrc1(int opcion , UnidadControl* UC);
void setALUsrc2(int opcion , UnidadControl* UC);
void setPCSr(int opcion , UnidadControl* UC);
void setMRd(int opcion , UnidadControl* UC);
void setMWr(int opcion , UnidadControl* UC);
void setRegSrc(int opcion , UnidadControl* UC);
void setALUCtrl(int opcion , UnidadControl* UC);
int getRegWrite(UnidadControl* UC);
int getALUsrc1(UnidadControl* UC);
int getALUsrc2(UnidadControl* UC);
int getPCSr(UnidadControl* UC);
int getMRd(UnidadControl* UC);
int getMWr(UnidadControl* UC);
int getRegSrc(UnidadControl* UC);
int getALUCtrl(UnidadControl* UC);
void  free_UC(UnidadControl* UC);
