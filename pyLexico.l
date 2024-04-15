%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include "definiciones.h"
    #include "tablaSimbolos/tablaSimbolos.h"
    #include "gestionErrores/gestionErrores.h"
    #include "tablasHash/tablaHash.h"
    #include "pySintactico.tab.h"

    void abrirArchivo(char *nombreArchivo);
    void cerrarArchivo();
%}

%option noyywrap
%option yylineno
%option noinput
%option nounput

/* ---------------- DEFINICIONES ----------------  */

/* Expresiones regulares básicas */
letra            [A-Za-z_]
digit            [0-9]
nonzerodigit     [1-9]
espacio          [ \t]
saltoLinea       \n
puntoComa        ;

/* ID */
ID               {letra}({letra}|{digit})*

/* Números */
decinteger       {nonzerodigit}(_?{digit})*
digitpart        {digit}([_]?{digit})*
fraction         "."{digitpart}
exponent         [eE][+-]?{digitpart}
pointfloat        ({digitpart}{fraction})|({digitpart}".")
exponentfloat     ({digitpart}|{pointfloat}){exponent}
floatnumber       {pointfloat}|{exponentfloat}
NUMERO           {decinteger}|{floatnumber}

/* Operadores y símbolos */
OPERADORES       [+*/%&,.:|^<>=!~()[\]{}-]
SUMASIGNACION    \+=
RESTASIGNACION   \-=
MULTASIGNACION   \*=
DIVASIGNACION    \/=
MODASIGNACION    %=
POTEASIGNACION   \^=
MAYORIGUAL       >=
MENORIGUAL       <=
IGUALDAD         ==


NOMBRE_ARCHIVO   {ID}(\.{letra}+)?


%%

{espacio}       ;        /* Ignorar espacios y tabulaciones */
{saltoLinea}    ;        return ((int) *yytext);

{ID}                     {yylval.cadena = strdup(yytext); return IDENTIFICADOR;}
{NUMERO}                 {yylval.numero = atof(yytext); return NUMERO;}

{OPERADORES}             {return ((int) *yytext);}
{SUMASIGNACION}          {return SUMA;}
{RESTASIGNACION}         {return RESTA;}
{MULTASIGNACION}         {return MULTIPLICACION;}
{DIVASIGNACION}          {return DIVISION;}
{MODASIGNACION}          {return MODULO;}
{POTEASIGNACION}         {return POTENCIA;}
{MAYORIGUAL}             {return MAYOR_IGUAL;}
{MENORIGUAL}             {return MENOR_IGUAL;}
{IGUALDAD}               {return IGUAL_IGUAL;}
<<EOF>>                  {cerrarArchivo(); yyrestart(stdin);}

%%

/* ----------------  FUNCIONES EN C ----------------  */

void abrirArchivo(char *nombreArchivo) {
    FILE *archivo = fopen(nombreArchivo, "r");
    if (archivo == NULL) {
        ficheroNoEncontrado(nombreArchivo);
        exit(EXIT_FAILURE);
    }
    yyin = archivo;
}

void cerrarArchivo() {
    if (yyin != NULL) {
        fclose(yyin);
        yyin = NULL;
    }
    yylex_destroy();
}
