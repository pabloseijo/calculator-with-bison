#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "./definiciones.h"
#include "./tablaSimbolos/tablaSimbolos.h"
#include "./analizadorSintactico/analizadorSintactico.h"
#include "./gestionErrores/gestionErrores.h"
#include "lex.yy.h"

int main(int argc,char *argv[]){

    char *nombreFichero = argv[1];

    if(argc != 2){
        numParametrosIncorrecto();
    }

    abrirArchivo(nombreFichero);

    hashTable tabla;

    inicializarTabla(&tabla);

    imprimirTabla(tabla);
    
    iniciarAnalisis(&tabla);

    imprimirTabla(tabla);

    destruirTabla(tabla);
    cerrarArchivo();

    printf("\n");
}