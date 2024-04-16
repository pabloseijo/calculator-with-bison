%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <ctype.h>
    #include <math.h>
    #include "./definiciones.h"
    #include "./tablaSimbolos/tablaSimbolos.h"
    #include "./gestionErrores/gestionErrores.h"
    #include "lex.yy.h"

    extern int yylex();
    void yyerror(char *mensaje);
    void mostrarAyuda();

%}

%union {
    char *cadena;
    float numero;
}

%start entrada

%token <numero> NUMERO
%token <cadena> NOMBRE_ARCHIVO
%token <cadena> IDENTIFICADOR

%token AYUDA
%token SALIR
%token LIMPIAR
%token ESPACIO_TRABAJO
%token TABLA
%token CARGAR

%token SUMA
%token RESTA
%token MULTIPLICACION
%token DIVISION
%token MODULO
%token POTENCIA
%token MAYOR_IGUAL
%token MENOR_IGUAL
%token IGUAL_IGUAL

%right ASIGNAR
%left '+' '-'
%left '*' '/'
%left '%' '^'

%type <numero> expresion
%type <numero> definicion
%type <numero> operaciones
%type <numero> booleano
%type <numero> archivo

%%

entrada:
    | entrada linea
;

linea:
    '\n' { printf("calculadoraBison:~$ "); }
    | expresion ';' '\n' { printf("> %f\ncalculadoraBison:~$ ", $1); }  
    | expresion '\n' { printf("\ncalculadoraBison:~$ "); }  
    | error { yyclearin; yyerrok; }
;


expresion:
    NUMERO { $$ = $1; }
    | '-' expresion { $$ = -$2; }
    | IDENTIFICADOR {
        if (buscarComponente($1) != 0) {
            $$ = obtenerValor($1);
        } else {
            yyerror("Variable no declarada");
        }
    }
    | '(' expresion ')' { $$ = $2; }
    | TABLA { imprimirTabla(); }
    | definicion
    | operaciones
    | booleano
    | archivo
;

definicion:
    IDENTIFICADOR '=' expresion {
        token t;
        t.lexema = $1;
        t.valorUnion.valor = $3;
        if(buscarComponente($1) == 0) {
            t.componente = VARIABLE;
            if (!insertarElemento(t, $3)) {
                yyerror("Error al insertar el elemento");
            } else {
                $$ = $3;
            }
        } else if(buscarComponente($1) == CONSTANTE) {
            yyerror("ERROR: LAS CTES NO SE PUEDEN REASIGNAR");
        } else {
            if (!modificarElemento(t, $3)) {
                yyerror("Error al modificar el elemento");
            } else {
                $$ = $3;
            }
        }
    }
;

operaciones:
    expresion '+' expresion { $$ = $1 + $3; }  
    | expresion '-' expresion { $$ = $1 - $3; }  
    | expresion '*' expresion { $$ = $1 * $3; } 
    | expresion '/' expresion {                
        if($3 != 0) {
            $$ = $1 / $3;
        } else {
            yyerror("ERROR: DIVISIÓN ENTRE CERO");
        }
    }
;


booleano:
    expresion '>' expresion { $$ = $1 > $3; }
    | expresion '<' expresion { $$ = $1 < $3; }
    | expresion MAYOR_IGUAL expresion { $$ = $1 >= $3; }
    | expresion MENOR_IGUAL expresion { $$ = $1 <= $3; }
    | expresion IGUAL_IGUAL expresion { $$ = $1 == $3; }
;

archivo:
    CARGAR NOMBRE_ARCHIVO { abrirArchivo($2); }

%%

void yyerror(char *mensaje) {
    fprintf(stderr, "Error: %s\n", mensaje);
}

void mostrarAyuda() {
    printf("\n\tAYUDA\n\t\t Imprime la función de ayuda\n\n");
    printf("\tSALIR\n\t\t Cierra el programa\n\n");
    printf("\tLIMPIAR\n\t\t Limpiar el buffer de variables y funciones\n\n");
    printf("\tWORKSPACE\n\t\t Muestra el espacio de trabajo\n\n");
    printf("\tTABLA\n\t\t Muestra la tabla de símbolos\n\n");
}
