import ply.lex as lex

%{
    #include "definiciones.h"
    #include "tablaSimbolos/tablaSimbolos.h"
    #include "gestionErrores/gestionErrores.h"
    #include "tablasHash/tablaHash.h"
%}


%option noyywrap

/* ---------------- DEFINICIONES ----------------  */

/* Ponemos las definiciones básicas que nos proporciona python.org */
letra            [A-Za-z_]
digit            [0-9]
nonzerodigit     [1-9]
binario          [01]
octal            [0-7]
hexadecimal      [0-9A-Fa-f]
espacio          [ \t\n]

/* ID */

ID               {letra}({letra}|{digit}|_)*

/* STRINGS */

/* Secuencias de Escape en Cadenas */
stringescapeseq  \\\\.

/* Caracteres de Cadena */
shortstringchar  [^\\]
longstringchar   [^\\\n]

/* Elementos de Cadena */
shortstringitem  ({shortstringchar}|{stringescapeseq})
longstringitem   ({longstringchar}|{stringescapeseq})

/* Cadenas Cortas y Largas */
shortstring      (\"([^\\\"]|{stringescapeseq})*\"|\'([^\\\']|{stringescapeseq})*\')
longstring       \"\"\"((\\.|\"?|\"\"?|[^\"\\])*)\"\"\"|\'\'\'((\\.|\'?|\'\'?|[^\'\\])*)\'\'\'


/* Prefijo de Cadena y Literal de Cadena Completo */
stringprefix      (r|u|R|U|f|F|fr|Fr|fR|FR|RF|rF|Rf|RF)?
stringliteral    {stringprefix}({shortstring})


/* INTEGERS */

decinteger       {nonzerodigit}(_?{digit})*
bininteger       "0"[bB](\_?{binario})+
octinteger       "0"[oO](\_?{octal})+
hexinteger       "0"[xX](\_?{hexadecimal})+
cero             "0"+
integernumber    {decinteger}|{bininteger}|{octinteger}|{hexinteger}|{cero}

/* FLOATS */

digitpart        {digit}([_]?{digit})*
fraction         "."{digitpart}
exponent         [eE][+-]?{digitpart}
pointfloat        ({digitpart}{fraction})|({digitpart}".")
exponentfloat     ({digitpart}|{pointfloat}){exponent}
floatnumber       {pointfloat}|{exponentfloat}
 
/* IMAGINARIOS */

imagnumber       ({floatnumber}|{digitpart})[jJ]

/* OPERADORES */

operadores       (\+\+|\-\-|\+|\-|\*{1,2}|\/{1,2}|\%|\@|\<\<|\>\>|\&|\||\^|\~|\:\=|\<|\>|\=\<|\>\=|\=\=|\!\=)

/* DELIMITADORES */ 

delimitadores     (\(|\)|\[|\]|\{|\}|,|:|\.|;|\@|\=|\->|\+=|\-=|\*=|\/=|\%=|\@=|\&=|\|=|\^=|>>=|<<=|\*\*=|\/\/=)


/* COMENTARIOS */

comentario        ("#"[^\n]*)|{longstring}

%%

{espacio}       ;    /* NO SE HACE NADA */
{comentario}    ;   /* NO SE HACE NADA */

{integernumber} { return NUM_INT; }
{ID}            { return ID; }
{stringliteral} { return STRING; }
{floatnumber}    { return NUM_FLOAT; }
{imagnumber}    { return NUM_FLOAT; }
{operadores}    { return OP; }
{delimitadores} { return DEL; }
.               {return -1;}
<<EOF>>         {return EOF;}

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


int seguinte_comp_lexico(token *actual, hashTable *tabla) {
    actual->componente = yylex();

    int aux = 0;

    if (actual->componente != 0) {
        actual->lexema = strdup(yytext);
        if(actual->componente == ID && ( aux = buscarElemento(actual->lexema, *tabla)) != 0){
            actual->componente = aux;
        }
        else if (actual->componente == ID) {
            insertarElemento(*actual, tabla);
        }
        return 1; 
    }

    return 0; 
}


void cerrarArchivo() {
    if (yyin != NULL) {
        fclose(yyin); 
        yyin = NULL; 
    }
    yylex_destroy();
}
