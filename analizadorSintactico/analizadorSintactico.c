/**
 * @file analizadorSintactico.c
 * @date 26/02/2024
 * @brief Implementación de las funciones del analizador sintáctico
 * 
 * Este archivo contiene la implementación de las funciones del analizador sintáctico. 
 * Se encarga de pedir componentes léxicos al analizador léxico y de imprimirlos.
*/

#include <stdio.h>
#include <stdlib.h>
#include "analizadorSintactico.h"
#include "../tablasHash/tablaHash.h"
#include "../lex.yy.h"


void imprimirComponenteLexico(token c);

/**
 * @brief Función que inicia el análisis léxico, pidiendo componentes léxicos al analizador
 * @param tabla: tabla de símbolos en la que se buscará el siguiente componente léxico
 * @param ficheroEntrada: fichero de entrada
 */
void iniciarAnalisis(hashTable *tabla) {
    token t;

    printf("%-33s %-10s\n", "Lexema", "ID");
    printf("--------------------------------- ----------\n");

    do {
        printf("--------------------------------- ----------\n");

        int liberarMemoria = seguinte_comp_lexico(&t, tabla);
        // Si ha habido algún error, o es el fin de fichero no se imprime el componente.
        if (t.componente != EOF && t.componente != 0) {
            imprimirComponenteLexico(t);
        }

        if(liberarMemoria) free(t.lexema);

    } while (t.componente != EOF);
}


// Imprime el componente léxico en la consola
void imprimirComponenteLexico(token t) {
    // Imprime los valores en el mismo ancho de columna que las cabeceras
    printf("%-33s %-10d\n", t.lexema, t.componente);
}