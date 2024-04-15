/**
 * @file tablaSimbolos.c
 * @date 26/02/2024
 * @brief Implementación de una tabla de simbolos para la abstraccion de la 
 * tabla hash
 * 
 * Implementa las funciones de la tabla de simbolos para la gestion de los
 * tokens en el compilador. Es una abstraction de la tabla hash.
 */

#include <stdio.h>
#include "../definiciones.h"
#include "tablaSimbolos.h"

#define TAM_INICIAL 64 // Metemos 64 espacios para minimizar el numero de redimensiones (puedes bajarlo para probar el resize)

hashTable tabla;

// Inicializacion de la tabla de símbolos con las palabras reservadas del lenguaje
int inicializarTabla(){

    char *keywords[3];

    keywords[0] = "pi";
    keywords[1] = "e";
    keywords[2] = "phi";

    if(initHashTable(&tabla, TAM_INICIAL) == 0){
        printf("Error al inicializar la tabla de hash\n");
        return 0;
    }

    if(insertToken(&tabla, keywords[0], CONSTANTE, PI) == 0){
        printf("Error al insertar el token %s en la tabla de hash\n", keywords[0]);
    }

    if(insertToken(&tabla, keywords[1], CONSTANTE, E) == 0){
        printf("Error al insertar el token %s en la tabla de hash\n", keywords[1]);
    }

    if(insertToken(&tabla, keywords[2], CONSTANTE, PHI) == 0){
        printf("Error al insertar el token %s en la tabla de hash\n", keywords[2]);
    }
    
    return 1;
}

// Destruye la tabla de símbolos llamando a la funcion de la tabla de hash
void destruirTabla(){
    deleteHashTable(tabla);
}

// Imprime la tabla de símbolos llamando a la funcion de la tabla de hash
void imprimirTabla(){
    printTable(tabla);
}

// Inserta el elemento en la tabla de símbolos llamando a la funcion de la tabla de hash
int insertarElemento(token t, float valor){
    return insertToken(&tabla, t.lexema, VARIABLE, valor);
}

// Modifica el elemento en la tabla de símbolos llamando a la funcion de la tabla de hash
int modificarElemento(token t, float valor){
    return modifyToken(&tabla, t.lexema, t.componente, valor);
}

// Busca el elemento en la tabla de símbolos llamando a la funcion de la tabla de hash
int buscarComponente(char *lexema){
    return searchTokenComponent(tabla, lexema);
}

// Borra el elemento en la tabla de símbolos llamando a la funcion de la tabla de hash
int borrarElemento(char *lexema){
    return deleteToken(tabla, lexema);
}

// Busca el valor asociado a un token por su lexema
float obtenerValor(char *lexema){
    return getValue(lexema, tabla);  
}
