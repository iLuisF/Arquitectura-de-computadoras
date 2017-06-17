#include <stdlib.h>
#include "UnidadControl.h"

/**
 * Representación de una Unidad de control para determinar que señales enviar.
 */
struct UnidadControl{
	int RegWrite;
	int ALUsrc1;
	int ALUsrc2;
	int PCSr;
	int ALUCtrl;
	int MRd;
	int MWr;
	int RegSrc;

};

/**
 * Se crea una nueva unidad de control
 * @return unidad de control.
 */
UnidadControl* nueva_UC()
{
	UnidadControl* nuevo_UC = malloc(sizeof(UnidadControl));
	return nuevo_UC;
}

/**
 * Especifica que el banco de registros debe aceptar la entrada WriteData y 
 * escribirla en el registro especificado en RegWrite.
 * @param opcion 1 = escribir, 0 = ignorar.
 * @param UC Unidad correspondiente.
 */
void setRegWrite(int opcion , UnidadControl* UC)
{
	UC->RegWrite = opcion;
}

/**
 * Escoge una opcion para saber si la entrada de la ALU debe ser NPC o registro
 * A.
 * @param opcion 0 = NPC, 1 = registro A
 * @param UC Unidad correspondiente.
 */
void setALUsrc1(int opcion , UnidadControl* UC)
{
	UC->ALUsrc1 = opcion;
}

/**
 * Escoge una opción para saber si la entrada de la ALU debe ser Imm o el
 * registro B.
 * @param opcion 0 = Imm, 1 = resgitro B.
 * @param UC Unidad correspondiente.
 */
void setALUsrc2(int opcion , UnidadControl* UC)
{
	UC->ALUsrc2 = opcion;
}

/**
 * Decide que debe ser el contenido de PC.
 * @param opcion 0 = NPC, 1 = NPC o 1 = salida de ALU.
 * @param UC Unidad de correspondiente.
 */
void setPCSr(int opcion , UnidadControl* UC)
{
	UC->PCSr = opcion;
}

/**
 * Le indica a la memoria que lea la localidad indicada en Adress y regresa su
 * contenido en LMD.  
 * @param opcion 1 = lectura, 0 = No lectura.
 * @param UC Unidad correspondiente.
 */
void setMRd(int opcion , UnidadControl* UC)
{
	UC->MRd = opcion;
}

/**
 * Le indica a la memoria si debe o no ser escrito el dato WriteData en Adress.
 * @param opcion 1 = escritura, 0 = no escritura.
 * @param UC Unidad correspondiente.
 */
void setMWr(int opcion , UnidadControl* UC)
{
	UC->MWr = opcion;
}

/**
 * Indica quien debe pasar como el dato a escribir en el banco de registros.
 * @param opcion 0 = LMD, 1 = ALU.
 * @param UC Unidad de control correspondiente.
 */
void setRegSrc(int opcion , UnidadControl* UC)
{
	UC->RegSrc = opcion;
}

/**
 * Especifica la iperación que debe efectuar la ALU. Debem ser unos tres o 
 * cuatro bits.
 * @param opcion
 * @param UC Unidad correspondiente.
 */
void setALUCtrl(int opcion , UnidadControl* UC)
{
	UC->ALUCtrl = opcion;
}

/**
 * Regresa la opción de RegWrite.
 * @param UC Unidad correspondiente.
 * @return opcion de RegWrite.
 */
int getRegWrite(UnidadControl* UC)
{
	return UC->RegWrite;
}

/**
 * Regresa la opción de ALUsrc1
 * @param UC unidad de control correspondiente.
 * @return opcion de ALUsrc1.
 */
int getALUsrc1(UnidadControl* UC)
{
	return UC->ALUsrc1 ;
}

/**
 * Regresa la opción de ALUsrc2.
 * @param UC Unidad de control correspondiente.
 * @return opción de ALUsr2.
 */
int getALUsrc2(UnidadControl* UC)
{
	return UC->ALUsrc2;
}

/**
 * Regresa la opción de PCSr.
 * @param UC Unidad de control correspondiente.
 * @return opción de PCSr.
 */
int getPCSr(UnidadControl* UC)
{
	return UC->PCSr;
}

/**
 * Regresa la opción de MemRead.
 * @param UC Unidad de control correspondiente.
 * @return Opción de Memread.
 */
int getMRd(UnidadControl* UC)
{
	return UC->MRd;
}

/**
 * Regresa la opción de MemWrite.
 * @param UC Unidad correspondiente.
 * @return Opción de MemWrite.
 */
int getMWr(UnidadControl* UC)
{
	return UC->MWr;
}

/**
 * Regresa la opción de RegSrc.
 * @param UC Unidad correpondiente.
 * @return Opción de RegSrc.
 */
int getRegSrc(UnidadControl* UC)
{
	return UC->RegSrc;
}

/**
 * Regresa la opción de ALUCtrl.
 * @param UC Unidad correspondiente.
 * @return Opción de ALUCtrl.
 */
int getALUCtrl(UnidadControl* UC)
{
	return UC->ALUCtrl ;
}

/**
 * Liberar el espacio ocupado por la Unidad de Control.
 * @param UC
 */
void  free_UC(UnidadControl* UC)
{
	free(UC);
}





