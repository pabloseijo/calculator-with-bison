/**
 * @file analizadorSintactico.h
 * @date 26/02/2024
 * @brief Definición de las funciones del analizador sintáctico
 * 
 * Este archivo contiene las definiciones de las funciones del analizador sintáctico
*/

#ifndef ANALIZADORSINTACTICO_H
#define ANALIZADORSINTACTICO_H

#include <stdio.h>
#include <stdlib.h>
#include "analizadorSintactico.h"
#include "../tablasHash/tablaHash.h"
#include "../lex.yy.h"

/**
 * Función que inicia el análisis léxico, pidiendo componentes léxicos al analizador
 * @param tabla: tabla de símbolos en la que se buscará el siguiente componente léxico
 */
void iniciarAnalisis(hashTable *tabla);

#endif // ANALIZADORSINTACTICO_H