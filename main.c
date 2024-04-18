#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "./definiciones.h"
#include "./tablaSimbolos/tablaSimbolos.h"
#include "./gestionErrores/gestionErrores.h"
#include "lex.yy.h"
#include "pySintactico.tab.h"

int main(int argc,char *argv[]){

    inicializarTabla();

    //imprimirTabla(tabla);
    
    printf("calculadoraBison:~$ ");

    yyparse();

    //imprimirTabla(tabla);

    destruirTabla();

    printf("\n");
}