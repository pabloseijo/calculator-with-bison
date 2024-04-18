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
#include "math.h"

#define TAM_INICIAL 16 // Metemos 16 espacios para minimizar el numero de redimensiones (puedes bajarlo para probar el resize)

hashTable tabla;

// Inicializacion de la tabla de símbolos con las palabras reservadas del lenguaje
int inicializarTabla(){

    token keywords[] = {
        {CONSTANTE, "pi", .valorUnion.valor = PI},
        {CONSTANTE, "e", .valorUnion.valor = E},
        {CONSTANTE, "phi",.valorUnion.valor = PHI},
        {FUNCION, "cos", .valorUnion.funcion1Arg = cos},
        {FUNCION, "sin", .valorUnion.funcion1Arg = sin},
        {FUNCION, "pow", .valorUnion.funcion2Args = pow},
        {FUNCION, "fmod", .valorUnion.funcion2Args = fmod},
    };

    if(initHashTable(&tabla, TAM_INICIAL) == 0){
        printf("Error al inicializar la tabla de hash\n");
        return 0;
    }

    for(int i = 0; i < sizeof(keywords)/sizeof(keywords[0]); i++){
        if(insertToken(&tabla, keywords[i]) == 0){
            printf("Error al insertar el token %s\n", keywords[i].lexema);
            return 0;
        }
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
    t.valorUnion.valor = valor;
    return insertToken(&tabla, t);
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

// Imprime el espacio de trabajo
void imprimirEspacioTrabajo(){
    printWorkingSpace(tabla);
}

// Elimina el espacio de trabajo
void eliminarEspacioTrabajo(){
    deleteWorkingSpace(tabla);
}

token obtenerToken(char *lexema){
    return getToken(tabla, lexema);
}
