%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include "./definiciones.h"
    #include "./tablaSimbolos/tablaSimbolos.h"
    #include "./gestionErrores/gestionErrores.h"
    #include "lex.yy.h"

    void yyerror(const char *s);

%}

%union {
    char *cadena;
    float num;
}

%start input

