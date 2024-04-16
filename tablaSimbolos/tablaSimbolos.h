/**
 * @file tablaSimbolos.h
 * @date 26/02/2024
 * @brief Definicion de una tabla de simbolos para la abstraccion de la 
 * tabla hash
 * 
 * Mejora la abstraccion de la implementacion de la tabla hash, permitiendo
 * al usuario trabajar con la tabla de simbolos sin tener que entender la 
 * tabla hash
 */

#ifndef TABLASIMBOLOS_H
#define TABLASIMBOLOS_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "../definiciones.h"
#include "../tablasHash/tablaHash.h"

//------------------------------- Funciones de Estructura ------------------------------

/**
 * @brief Función que inicializa la tabla de símbolos, introduciendo las palabras reservadas del lenguaje
 * @return 1 si se ha inicializado correctamente, 0 si no se ha podido inicializar
*/
int inicializarTabla();

/**
 * @brief Función que destruye la tabla de símbolos
*/
void destruirTabla();

/**
 * @brief Función que imprime la tabla de símbolos
*/
void imprimirTabla();


//------------------------------- Funciones de Interacción ------------------------------

/**
 * @brief Función que inserta un elemento en la tabla de símbolos
 * @param t: variable de tipo token que contiene el componente léxico a insertar
 * @param valor: valor que se le asignará al componente léxico
 * @return 1 si se ha insertado correctamente, 0 si no se ha podido insertar
*/
int insertarElemento(token t, float valor);

/**
 * @brief Función que modifica un elemento en la tabla de símbolos es importante entender que el 
 *        lexema no se puede modificar, por que si no no se podria encontrar el token (Hay que 
 *        pasarle el componente ya modificado)
 * @param t: variable de tipo token que contiene el componente léxico a modificar
 * @param valor: valor que se le asignará al componente léxico
*/
int modificarElemento(token t, float valor);

/**
 * @brief Función que busca un elemento en la tabla de símbolos. 
 * @param lexema: lexema que se buscará
 * @return componente léxico si se ha encontrado, 0 si no se ha encontrado
*/
int buscarComponente(char *lexema);

/**
 * @brief Función que borra un elemento en la tabla de símbolos
 * @param lexema: lexema que se eliminará
 * @return 1 si se ha eliminado correctamente, 0 si no se ha podido eliminar
*/
int borrarElemento(char *lexema);

/**
 * @brief Función que obtiene el valor asociado a un token por su lexema
 * @param lexema: lexema del token
*/
float obtenerValor(char *lexema);

/**
 * @brief Función que imprime el espacio de trabajo
*/
void imprimirEspacioTrabajo();

/**
 * @brief Función que elimina el espacio de trabajo
*/
void eliminarEspacioTrabajo();

#endif	// TABLASIMBOLOS_H