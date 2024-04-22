# Intérprete matemático

## Descripción

Este proyecto implementa un intérprete de calculadora matemática utilizando Bison y Flex, que permite realizar tanto operaciones básicas como funciones matemáticas más complejas. Utiliza una tabla de símbolos implementada mediante una tabla de hash para optimizar la búsqueda y almacenamiento de variables y funciones.

## Entorno de Desarrollo

- **IDE**: Visual Studio Code
- **Lenguaje**: C
- **OS**: MacOs ventura y Ubuntu 22.04

## Archivos del Proyecto

- **main.c**: Punto de entrada del intérprete.
- **tablaSimbolos.h**, **tablaSimbolos.c**: Definiciones e implementación de la tabla de símbolos.
- **tablaHash.h**, **tablaHash.c**: Definiciones e implementación de la tabla de hash.
- **analizadorSintactico.y**: Gramática y acciones sintácticas implementadas con Bison.
- **analizadorLexico.l**: Reglas léxicas implementadas con Flex.
- **gestionErrores.h**, **gestionErrores.c**: Manejo de errores durante la ejecución.
- **definiciones.h**: Constantes y tipos utilizados en el proyecto.

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

Tenemos que tener en cuenta que para que nos muestre el resultado por pantalla debemos poner ';' al final de cada línea, por ejemplo:

```
calculadoraBison:~$ 3+3
calculadoraBison:~$ 3+3;
» 6.00
```

Esto funciona así aunque este el echo activado (si está desactivado no se mostrará en ningún caso).

En el caso de las funciones no es necesario poner ';':

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

