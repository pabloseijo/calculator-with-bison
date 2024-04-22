# Intérprete matemático

![C](https://img.shields.io/badge/language-C-blue.svg)
![GCC](https://img.shields.io/badge/compiler-GCC-pink.svg)
![Flex](https://img.shields.io/badge/lexer-Flex-purple.svg)
![Bison](https://img.shields.io/badge/parser-Bison-cyan.svg)

## Índice

- [Descripción](#descripción)
- [Entorno de Desarrollo](#entorno-de-desarrollo)
- [Archivos del Proyecto](#archivos-del-proyecto)
- [Compilación y Ejecución](#compilación-y-ejecución)
- [Comandos Disponibles](#comandos-disponibles)
- [Uso](#uso)
- [Mensaje Final](#mensaje-final)

## Descripción

Este proyecto implementa un intérprete de calculadora matemática utilizando Bison y Flex, que permite realizar tanto operaciones básicas como funciones matemáticas más complejas. Utiliza una tabla de símbolos implementada mediante una tabla de hash para optimizar la búsqueda y almacenamiento de variables y funciones.

## Entorno de Desarrollo

- **IDE**: Visual Studio Code
- **Lenguaje**: C
- **OS**: MacOs Ventura y Ubuntu 22.04

## Archivos del Proyecto

### `main.c`
- **Descripción**: Punto de entrada del intérprete. Este archivo contiene la función principal `main`, que inicializa la tabla de símbolos, maneja la interacción del usuario y controla el flujo general del programa. Es responsable de invocar el analizador sintáctico para procesar las entradas del usuario y mostrar resultados.
- **Funcionalidades clave**:
  - Inicialización y destrucción de la tabla de símbolos.
  - Invocación del parser y del lexer.
  - Gestión de la interfaz de línea de comando.

#### `tablaSimbolos.h`, `tablaSimbolos.c`
- **Descripción**: Estos archivos definen e implementan las operaciones de la tabla de símbolos. La tabla de símbolos almacena información sobre variables, constantes y funciones, permitiendo al intérprete recordar valores y comportamientos definidos.
- **Funcionalidades clave**:
  - Inserción y búsqueda de elementos.
  - Modificación y eliminación de variables.
  - Soporte para manejo de diferentes tipos de datos a través de uniones.

#### `tablaHash.h`, `tablaHash.c`
- **Descripción**: Implementan la tabla de hash utilizada por la tabla de símbolos para almacenar eficientemente los identificadores y sus asociaciones. Utiliza técnicas de hashing para acelerar las búsquedas y actualizaciones.
- **Funcionalidades clave**:
  - Funciones hash personalizadas para distribución uniforme.
  - Manejo de colisiones mediante listas enlazadas.
  - Redimensionamiento dinámico para mantener la eficiencia a medida que crece el número de elementos.

#### `analizadorSintactico.y`
- **Descripción**: Define la gramática del lenguaje y las acciones asociadas utilizando Bison. Este archivo contiene las reglas sintácticas que dictan la estructura del lenguaje y cómo las entradas son convertidas en operaciones ejecutables.
- **Funcionalidades clave**:
  - Definición de operadores, prioridades y asociatividades.
  - Implementación de acciones que se ejecutan al reconocer patrones en la entrada.

#### `analizadorLexico.l`
- **Descripción**: Implementado con Flex, este archivo contiene las reglas léxicas que el lexer utiliza para descomponer la entrada de texto en tokens que el parser puede entender.
- **Funcionalidades clave**:
  - Identificación de tipos de tokens como números, identificadores y símbolos operativos.
  - Manejo de espacios, comentarios y líneas nuevas para adecuar la entrada para el parsing.

#### `gestionErrores.h`, `gestionErrores.c`
- **Descripción**: Proporcionan mecanismos para reportar y manejar errores durante el análisis léxico y sintáctico. Estos archivos son cruciales para una buena experiencia de usuario al proporcionar mensajes de error claros y acciones de recuperación.
- **Funcionalidades clave**:
  - Definición de diferentes tipos de errores.
  - Funciones para mostrar mensajes de error y manejar errores no críticos.

#### `definiciones.h`
- **Descripción**: Contiene definiciones de constantes y estructuras de datos usadas a través del proyecto. Este archivo centraliza elementos como tipos de tokens y valores especiales, facilitando la modificación y mantenimiento del código.
- **Funcionalidades clave**:
  - Definiciones de constantes matemáticas y de sistema.
  - Estructuras para manejo de tokens y errores.

Cada archivo está diseñado para trabajar en conjunto, proporcionando una base robusta para el intérprete que es fácil de entender.


## Compilación y Ejecución

Para compilar el proyecto, asegúrate de que todos los archivos estén en el mismo directorio y ejecuta:

```
cd <carpeta-del-proyecto>
make
```

Para ejecutar el siguiente intérprete:

```
./bin/miInterprete
```

Utiliza make clean para limpiar objetos compilados y make cleanall para eliminar todos los archivos generados.

## Comandos Disponibles

- `help`: Muestra ayuda del programa.
- `table`: Visualiza la tabla de símbolos global.
- `workspace`: Muestra las variables y sus valores hasta el momento.
- `clear`: Elimina todas las variables del workspace.
- `echo`: Activa/Desactiva el mostrar las variables.
- `load file`: Carga y ejecuta operaciones de un archivo.
- `exit`: Sale del programa.

## Uso 

### Ejecución Básica

Para ejecutar operaciones matemáticas básicas, es necesario terminar cada comando con un punto y coma (`;`) para que el intérprete procese la entrada. Esto aplica incluso si el `echo` está activado, lo que significa que el intérprete muestra resultados de operaciones a medida que son procesadas:


```
calculadoraBison:~$ 3+3
calculadoraBison:~$ 3+3;
» 6.00
```

Esto funciona así aunque este el echo activado (si está desactivado no se mostrará en ningún caso).

### Operaciones Aritméticas Básicas y Especiales

El intérprete soporta varias operaciones matemáticas básicas y especiales, incluyendo:

- **Suma** (`+`)
- **Resta** (`-`)
- **Multiplicación** (`*`)
- **División** (`/`)
- **Exponente** (`^`): Para realizar operaciones de potencia.
- **Módulo** (`%`): Para obtener el residuo de una división.

### Funciones Matemáticas

Además de las operaciones aritméticas básicas, el intérprete incluye funciones matemáticas predefinidas:

- `cos(x)`: Coseno de un ángulo x.
- `sin(x)`: Seno de un ángulo x.
- `log(x)`: Logaritmo de x.
- `pow(x, y)`: Potencia de x elevado a y.
- `fmod(x, y)`: Módulo de x dividido por y.

### Uso de Funciones

Para ejecutar funciones almacenadas en un archivo, no es necesario terminar con `;`. El intérprete ejecutará las operaciones listadas en el archivo y mostrará los resultados automáticamente:

```
calculadoraBison:~$ load archivo.txt
» 1.00
» 5.00
» 6.00
» 23.35

------ Espacio de trabajo ------

a = 1.00
b = 5.00
s = 23.35

--------------- x ---------------

calculadoraBison:~$ clear
calculadoraBison:~$ workspace

------ Espacio de trabajo ------

No hay variables definidas.

--------------- x ---------------
```

Cabe destacar que cuando se carga un archivo debe pulsarse enter de nuevo al final para salir del load, y así poder ejecutar un nuevo comando u operación:

**Pre enter**:
```
calculadoraBison:~$ load archivo.txt
» 1.00
» 5.00
» 6.00
» 23.35

------ Espacio de trabajo ------

a = 1.00
b = 5.00
s = 23.35

--------------- x ---------------
```

**Post enter**:
```
calculadoraBison:~$ load archivo.txt
» 1.00
» 5.00
» 6.00
» 23.35

------ Espacio de trabajo ------

a = 1.00
b = 5.00
s = 23.35

--------------- x ---------------

calculadoraBison:~$ 
```

### Consideraciones Adicionales

- El intérprete es sensible al contexto de los comandos, lo que significa que los usuarios deben seguir el formato adecuado para asegurar el correcto procesamiento de las entradas.
- El manejo de errores es fundamental; si se encuentra con mensajes de error, verifique la sintaxis y la validez de las operaciones realizadas.

## Mensaje Final

Gracias por visitar y explorar el proyecto de intérprete matemático. 
