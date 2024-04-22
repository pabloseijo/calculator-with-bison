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
    void activarEcho();
    int devolverEcho();

    int echoGlobal = 1;

    token componente;
%}

%union {
    char *cadena;
    float numero;
}

%start entrada

%token <numero> NUMERO
%token <cadena> NOMBRE_ARCHIVO
%token <cadena> IDENTIFICADOR

%token HELP
%token EXIT
%token CLEAR
%token WORKSPACE
%token DELETE_WORKSPACE
%token TABLA
%token LOAD
%token CMD_ECHO

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
%nonassoc MAYOR_IGUAL MENOR_IGUAL IGUAL_IGUAL '>' '<'

%destructor {
    free($<cadena>$);
} <cadena>

%type <numero> expresion
%type <numero> definicion
%type <numero> operaciones
%type <numero> booleano
%type <numero> funciones

%%

entrada:
    | entrada linea
;

linea:
    '\n' { if(!getLoading()) printf("calculadoraBison:~$ "); }
    | expresion ';' '\n' {
            if(!getLoading()){
                if(devolverEcho()) {printf("» %.2f\n", $1);} 
                printf("calculadoraBison:~$ "); 
            } else {
                if(devolverEcho()) {printf("» %.2f\n", $1);} 
            }
        }  
    | expresion '\n' {if(!getLoading()) printf("calculadoraBison:~$ "); }  
    | error { yyclearin; yyerrok;}
;

expresion:
    NUMERO { $$ = $1; }
    | '-' expresion %prec '-' { $$ = -$2; }
    | IDENTIFICADOR {
        if (buscarComponente($1) != 0) {
            $$ = obtenerValor($1);
            free($1); // Considerar mover esta liberación a después de su último uso
        } else {
            yyerror("Variable no declarada");
            free($1); // Asegurar liberación en todas las ramas
        }
    }
    | '(' expresion ')' { $$ = $2; }
    | WORKSPACE { imprimirEspacioTrabajo(); }
    | DELETE_WORKSPACE { eliminarEspacioTrabajo(); }
    | HELP { mostrarAyuda(); }
    | TABLA { imprimirTabla(); }
    | LOAD NOMBRE_ARCHIVO {
        abrirArchivo($2);
        free($2); // Asegurarse que el archivo no se usa después
    }
    | CMD_ECHO { activarEcho(); }
    | definicion
    | operaciones
    | booleano
    | funciones
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
            yyerror("Las constantes no se pueden reasignar");
        } else if(buscarComponente($1) == FUNCION) {
            yyerror("Las funciones no se pueden reasignar");
        } else {
            if (!modificarElemento(t, $3)) {
                yyerror("Error al modificar el elemento");
            } else {
                $$ = $3;
            }
        }
        free($1);
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
            yyerror("división entre 0");
        }
    }
;

funciones:	
    IDENTIFICADOR '(' expresion ')' {
        if(buscarComponente($1) == FUNCION) {
            componente = obtenerToken($1);
            if(componente.valorUnion.funcion1Arg != NULL){
                 $$ = (*(componente.valorUnion.funcion1Arg))((double)$3);
            } else {
                yyerror("Argumentos de la función incorrectos");
            }
        } 
        else {yyerror("La función no existe");}
        free($1); 
    }
    | IDENTIFICADOR '(' expresion ',' expresion ')' {
        if(buscarComponente($1) == FUNCION) {
            componente = obtenerToken($1);
            if (componente.valorUnion.funcion2Args != NULL) {
                $$ = (*(componente.valorUnion.funcion2Args))((double)$3,(double)$5);
            } else {
                yyerror("Argumentos de la función incorrectos");
            }
        } 
        else {yyerror("La función no existe"); printf("\n");}
        free($1); 
    }
    | expresion '^' expresion { $$ = pow($1, $3); }
    | expresion '%' expresion { $$ = fmod($1, $3); }
;

booleano:	
    expresion '>' expresion { $$ = $1 > $3; }
    | expresion '<' expresion { $$ = $1 < $3; }
    | expresion MAYOR_IGUAL expresion { $$ = $1 >= $3; }
    | expresion MENOR_IGUAL expresion { $$ = $1 <= $3; }
    | expresion IGUAL_IGUAL expresion { $$ = $1 == $3; }
;


%%

void activarEcho(){
    echoGlobal = !echoGlobal;
    printf("visualización de variables (%d)\n", echoGlobal);
}

int devolverEcho(){
    return echoGlobal;
}

void yyerror(char *mensaje) {
    fprintf(stderr, "Error: %s\n", mensaje);
}

void mostrarAyuda() {

    printf("\nUsage: [operation] | [command]\n");

    printf("\nCommands: \n");
    printf("\n\t help \n\t\t Imprime la función de ayuda\n\n");
    printf("\t exit \n\t\t Cierra el programa\n\n");
    printf("\t workspace \n\t\t Muestra el espacio de trabajo\n\n");
    printf("\t clear \n\t\t Elimina el espacio de trabajo\n\n");
    printf("\t table \n\t\t Muestra la tabla de símbolos\n\n");
    printf("\t echo \n\t\t Activa la visualización de las operaciones\n\n");
}
