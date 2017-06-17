#include "FlujoDatos.h"
#include <stdlib.h>
#include "funcionesCadenas.h"
#include "ALU.h"
#include "BancoRegistros.h"
#include "UnidadControl.h"

char ** memoria_texto;
char ** memoria_datos;
int program_counter;
char * instruction_register;
int memoria_de_datos;
int memoria_de_texto;
int tipo_instruccion;
int fin_ciclo;
BancoRegistro *banco_registros;
ALU * ALU1;
UnidadControl* UC;
char* LMD;


void decodificaInstruccion();
int ObtenInstruccion();
void LlenaBanco(int instruccion);
void ProcesaTipoR();
char * Registro(int despla);
char * Funcion(int despla);
void LlenaALU();
void ProcesaTipoI_IN();
char * Inmediato(int despla);
void ProcesaTipoJ();
void ProcesaTipoI_JR();
void ProcesaTipoI_B(int instruccion);
void setelemUnidadControl(int RegWrite , int ALUsrc1 , int ALUsrc2 , int PCSr , int ALUCtrl , int MRd , int MWr , int RegSrc);
char * SacaMemoriaDatos(char* lugar);
char * Byte(int despla , char *linea);
char * HalfWord(int despla , char *linea);
void GuardaMemoria(char *lugar);
void InicializaMemDatos();

/**
 * Llena la memoria apartir de un archivo.
 */
void LlenaMemoria(FILE *archivo)
{
	rewind(archivo);
	char datos[33];
	int i = 0;
	int numero_de_renglones;
	fread( datos , sizeof(char), 11 , archivo);
	datos[10] = '\0';
	memoria_de_datos = stoi(datos);
	fread( datos , sizeof(char), 11 , archivo);
	datos[10] = '\0';
	memoria_de_texto = stoi(datos);
	numero_de_renglones = memoria_de_texto/4;
	memoria_texto = malloc(sizeof(char *) * numero_de_renglones);
	while(i < numero_de_renglones){
		fread(datos , sizeof(char) , 33 , archivo);
		datos[32] = '\0';
		memoria_texto[i] = strclone(datos);
		i++;
	}
	numero_de_renglones = memoria_de_datos/4;
	memoria_datos = malloc(sizeof(char *) * 512);
	i = 0;
	while(i < numero_de_renglones){
		fread(datos , sizeof(char) , 33 , archivo);
		datos[32] = '\0';
		memoria_datos[i] = strclone(datos);
		i++;
	}
	program_counter = 2048;
	banco_registros = nuevo_BR();
	InicializaRegistros(banco_registros);
	InicializaMemDatos();
	ALU1 = nueva_ALU();
	UC = nueva_UC();
}

/**
 * Representación de la ruta de datos.
 */
void RutaDeDatos(){
	while((program_counter-2048) < memoria_de_texto){
		decodificaInstruccion();
		char * resultado = RealizaOperacion(ALU1);

		if(getRegWrite(UC)){
			if(getRegSrc(UC)){
				setRegistro(getEscribirRegistro(banco_registros) , resultado , banco_registros);
			}else{
				LMD = SacaMemoriaDatos(resultado);
				setRegistro(getEscribirRegistro(banco_registros) , LMD , banco_registros);
			}

		}else if(getMWr(UC)){
			GuardaMemoria(resultado);
		}

		if(!getPCSr(UC)){
			program_counter += 4;
		}
	}
}

/**
 * Llena el banco de registros.
 */
void decodificaInstruccion()
{
	instruction_register = memoria_texto[((program_counter-2044)/4)-1];
	int instruccion;
	instruccion = ObtenInstruccion();
	LlenaBanco(instruccion);

}

/*
 * Se obtiene la instrucción.
 */
int ObtenInstruccion()
{
	int resultado ;
	char palabra[7];
	int i;
	for(i = 0 ; i < 6 ; i++){
		palabra[i] = instruction_register[i];
	}
	palabra[6] = '\0';
	resultado = btoi(palabra);
	return resultado;
}

/**
 * Se llena el banco de registros dependiendo la instrucción.
 */
void LlenaBanco(int instruccion)
{
	switch(instruccion){
	case 0:
		ProcesaTipoR();
		LlenaALU();
		break;
	case 1:
	case 2:
	case 3:
	case 4:
	case 5:
	case 6:
	case 7:
	case 8:
	case 9:
	case 10:
		ProcesaTipoI_IN();
		switch(instruccion){
		case 1:
		case 2:
		case 3:
			setelemUnidadControl(1 , 1 , 0 , instruccion , 0 , 1 , 0 , 0);

			break;
		case 4:
		case 5:
		case 6:
			setelemUnidadControl(0 , 1 , 0 , instruccion , 0 , 0 , 1 , 0);

			break;
		case 7:
		case 8:
		case 9:
		case 10:
			setelemUnidadControl(1 , 1 , 0 , instruccion , 0 , 0 , 0 , 1);
			break;
		}
		LlenaALU();
		break;
	case 11:
	case 12:
		ProcesaTipoI_B(instruccion);
		setelemUnidadControl(0 , 0 , 0 , instruccion , 1 , 0 , 0 , 0);
		break;
	case 13:
		ProcesaTipoI_JR();
		setelemUnidadControl(0 , 0 , 0 , instruccion , 1 , 0 , 0 , 0);
		break;
	case 18:
		ProcesaTipoJ();
		setelemUnidadControl(0 , 0 , 0 , instruccion , 1 , 0 , 0 , 0);
		break;
	}
}

/**
 * Procesa las instrucciones tipo R. Si son de tipo R saca los componentes de la
 * construccion codificada con ese tipo.
 */
void ProcesaTipoR()
{
	char *reg;
	reg = Registro(6);
	setEscribirRegistro(btoi(reg) , banco_registros);

	reg = Registro(11);
	setRegistroA(btoi(reg) , banco_registros);

	reg = Registro(16);
	setRegistroB(btoi(reg) , banco_registros);

	reg = Funcion(21);
	setelemUnidadControl(1 , 1 , 0 , btoi(reg) , 0 , 0 , 0 , 1);
}

/**
 * Regresa una fución de tipo R.
 * @return Función de tipo R.
 */
char * Funcion(int despla)
{
	char * reg = malloc(11*sizeof(char));
	int i = 0;
	while( i < 11){
		reg[i] = instruction_register[i + despla];
		i++;
	}
	reg[11] = '\0';
	return reg;
}

/**
 * Regresa el registro de cualquier función dado que todos los registros estan a
 * 5 bits. 
 */
char * Registro(int despla)
{
	char * reg = malloc(5*sizeof(char));
	int i = 0;
	while( i < 5){
		reg[i] = instruction_register[i + despla];
		i++;
	}
	reg[5] = '\0';
	return reg;
}
/**
 * Se encarga de llenar la ALU desde el banco de registros.
 */
void LlenaALU(){

	if(getALUsrc1(UC)){
		setALURegistroA(getRegistro(getRegistroA(banco_registros) , banco_registros) , ALU1);
	}

	if(getALUsrc2(UC)){
		setALURegistroB(getRegistro(getRegistroA(banco_registros) , banco_registros) , ALU1);
	}

	setALUOperacion (getALUCtrl(UC) , ALU1);
}

/**
 * Procesa las intrcucciones de tipo inmediato.
 */
void ProcesaTipoI_IN()
{
	char *reg;
	reg = Registro(6);
	setEscribirRegistro(btoi(reg) , banco_registros);


	reg = Registro(11);
	setRegistroA(btoi(reg) , banco_registros);

	reg = Inmediato(16);
	setALURegistroB(reg , ALU1);
}

/**
 * Regresa un inmediato.
 */
char * Inmediato(int despla)
{
	char * reg = malloc(33*sizeof(char));
	int i = 0;
	int j = 0;
	while(j <= 15){
		reg[j] = '0';
		j++;
	}
	if(instruction_register[i + despla] == 1){
		reg[0] = 1;
	}
	i++;
	while( i < 16){
		reg[j] = instruction_register[i + despla];
		i++;
		j++;
	}

	reg[32] = '\0';
	return reg;
}

/**
 * Procesa las instrucciones tipo J. Si son de tipo J saca los componentes de la
 * construccion codificada con ese tipo.
 */
void ProcesaTipoJ(){
	char *dir_mem = malloc(27*sizeof(char));
	int i = 0;
	while(i < 26){
		dir_mem[i] = instruction_register[i +6];
		i++;
	}
	dir_mem[26] = '\0';
	program_counter = btoi(dir_mem);
}

/**
 * Procesa la instrucción de tipo inmediato.
 */
void ProcesaTipoI_JR()
{
	char *reg;
	reg = Registro(6);
	setRegistroA(btoi(reg) , banco_registros);

	reg = Inmediato(16);
	program_counter = btoi(reg);

}

/**
 * Procesa la instrucción de tipo inmediato pero solo las branch.
 */
void ProcesaTipoI_B(int instruccion)
{
	char *reg;
	reg = Registro(6);
	int num1 = btoi(getRegistro(btoi(reg) , banco_registros));

	reg = Registro(11);
	int num2 =  btoi(getRegistro(btoi(reg) , banco_registros));

	reg = Inmediato(16);
	switch(instruccion){
	case 11:
		if(num1 == num2){
			program_counter = btoi(reg);
		}else{
			program_counter +=4;
		}
		break;
	case 12:
		if(num1 > num2){
			program_counter = btoi(reg);
		}else{
			program_counter +=4;
		}

		break;
	}
}

/**
 * Coloca un elemento en la unidad de control, para esto es necesario los 
 * siguientes datos de la unidad correspondientes: RegWrite, ALUsrc1, ALUsrc2,
 * ALUCtrl, PCSr, MRd, MWr, RegSrc.
 */
void setelemUnidadControl(int RegWrite , int ALUsrc1 , int ALUsrc2 , int ALUCtrl , int PCSr , int MRd , int MWr , int RegSrc){
	setMRd(MRd , UC);
	setMWr(MWr , UC);
	setALUsrc1(ALUsrc1 , UC);
	setALUsrc2(ALUsrc2 , UC);
	setALUCtrl(ALUCtrl , UC);
	setRegWrite(RegWrite , UC);
	setPCSr(PCSr , UC);
	setRegSrc(RegSrc , UC);
}

/**
 * Saca de la memoria de datos el dato que esta en la posición lugar.
 * @param lugar - posición del dato.
 * @return  dato que esta en la memoria lugar
 */
char * SacaMemoriaDatos(char* lugar)
{
	char * resultado ;
	int pos = btoi(lugar);
	char * linea = memoria_datos[(pos/4)-1];
	switch(getALUCtrl(UC)){
	case 1:
		resultado = strclone(linea);
		break;
	case 2:
		resultado = HalfWord(pos , linea);
		break;
	case 3:
		resultado = Byte(pos , linea);
		break;
	}
	return resultado;
}

/**
 * Saca un byte de la métrica de datos.
 */
char * Byte(int despla , char *linea)
{
	char * resultado = malloc(sizeof(char)* 33);
	int i = 0;
	while(i < 24){
		resultado[i] = '0';
		i++;
 	}
        
	despla = despla%4;
	int j = 0;
	while( i < 32){
		resultado[i] = linea[(despla*8)+ j];
		j++;
		i++;
	}
	resultado[32] = '\0';
	return resultado;
}

/**
 * Saca un media palabra de la memoria.
 */
char *HalfWord(int despla , char* linea){
	char * resultado = malloc(sizeof(char)* 33);
	int i = 0;
	while(i < 16){
		resultado[i] = '0';
		i++;
	}
	despla = despla%4;
	int j = 0;
	while( i < 32){
		resultado[i] = linea[(despla*16)+ j];
		j++;
		i++;
	}
	resultado[32] = '\0';
	return resultado;
}

/**
 * Guarda en la memoria las instrucciones.
 */
void GuardaMemoria(char *lugar )
{
	int pos;
	pos = btoi(lugar);
	int renglon =(pos/4)-1;
	int caracter_str1 = 31;
	int caracter_mem = ((pos % 4) * 8)-1;
	int fin ;
	char* cadena2 = getRegistro(getEscribirRegistro(banco_registros) , banco_registros);
	switch(getALUCtrl(UC)){
	case 4:
		fin = 0;
		caracter_mem = 31;
		break;
	case 5:
		fin = 16;
		break;
	case 6:
		fin = 24;
		break;
	}
	 while(caracter_str1 >= fin){
		 if(cadena2[caracter_str1] == '0'){
			 memoria_datos[renglon][caracter_mem] = '0';
		 }else{
			 memoria_datos[renglon][caracter_mem] = '1';
		 }
		 caracter_str1 --;
		 caracter_mem--;
	 }
	if(pos > memoria_de_datos){
		memoria_de_datos = pos;
	}

}

/**
 * Se escriben dos archivos, uno donde esan los registros y otro donde esta
 * la memoria de datos.
 */
void EscribeArchivos(FILE * archivo1 , FILE *archivo2)
{
	int i  = 0;
	while(i < 32){

		fwrite(getRegistro(i , banco_registros) , sizeof(char) , 32 , archivo1);
		fwrite("\n" , sizeof(char) , 1, archivo1);
		i++;
	}
	i = 0;
	while(i < memoria_de_datos/4){
		fwrite(memoria_datos[i] , sizeof(char) , 32 , archivo2);
		fwrite("\n" , sizeof(char) , 1, archivo2);
		i++;
	}
}

/**
 * Inicializa la memoria de datos con una cadena predeterminada.
 */
void InicializaMemDatos()
{
	char cadena[33] = "00000000000000000000000000000000\0";
	int i = 511;
	while(i > (memoria_de_datos/4)-1){
		memoria_datos[i] = strclone(cadena);
		i--;
	}
}

/**
 * Libera la memoria de elementos.
 */
void freeElementos()
{
	free(memoria_datos);
	free(memoria_texto);
	free(instruction_register);
	free(LMD);
	free_ALU(ALU1);
	free_BR(banco_registros);
	free_UC(UC);
}
