import ply.lex as lex

%{
    #include "definiciones.h"
    #include "tablaSimbolos/tablaSimbolos.h"
    #include "gestionErrores/gestionErrores.h"
    #include "tablasHash/tablaHash.h"
%}


%option noyywrap
%option yylineno
%option noinput
%option nounput


/* ---------------- DEFINICIONES ----------------  */

/* Ponemos las definiciones básicas que nos proporciona python.org */
letra            [A-Za-z_]
digit            [0-9]
nonzerodigit     [1-9]
espacio          [ \t]
saltoLinea       \n
puntoComa        ;

/* ID */

ID               {letra}({letra}|{digit})*

/* INTEGERS */

decinteger       {nonzerodigit}(_?{digit})*

/* FLOATS */

digitpart        {digit}([_]?{digit})*
fraction         "."{digitpart}
exponent         [eE][+-]?{digitpart}
pointfloat        ({digitpart}{fraction})|({digitpart}".")
exponentfloat     ({digitpart}|{pointfloat}){exponent}
floatnumber       {pointfloat}|{exponentfloat}
 
NUMERO           {decinteger}|{floatnumber}

/* OPERADORES */
    
OPERADORES       [+*/%&,;.:|^<>=!~()[\]{}-]

SUMASIGNACION    \+=
RESTASIGNACION   \-=
MULTASIGNACION   \*=
DIVASIGNACION    \/=
MODASIGNACION    %=
POTEASIGNACION   \^=
MAYORIGUAL       >=
MENORIGUAL       <=
IGUALDAD         ==
ASIGNACION       =

%x READ

%%

{espacio}       ;        /* NO SE HACE NADA */ 
{saltoLinea}    ;        return ((int) *yytext);

{ID}                     {yylval.lexema = (char *) malloc(sizeof(yytext)); yylval.lexema = strdup(yytext); return ID;}
{NUMERO}                 {yylval.num = atof(yytext); return NUM;}

{OPERADORES}             {return ((int) *yytext);}
{SUMASIGNACION}          return SUMA;
{RESTASIGNACION}         return RESTA;
{MULTASIGNACION}         return MULT;
{DIVASIGNACION}          return DIV;
{MODASIGNACION}          return MOD;
{POTEASIGNACION}         return EXP;
{MAYORIGUAL}             return MAYORIGUAL;
{MENORIGUAL}             return MENORIGUAL;
{IGUALDAD}               return IGUALIGUAL;
<<EOF>>                  {cerrar(); yyrestart(stdin);}

%%

 /* ----------------  CODIGO C ----------------  */

// Abrimos el archivo
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
