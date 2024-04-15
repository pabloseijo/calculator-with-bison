/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMERO = 258,
     NOMBRE_ARCHIVO = 259,
     IDENTIFICADOR = 260,
     AYUDA = 261,
     SALIR = 262,
     LIMPIAR = 263,
     ESPACIO_TRABAJO = 264,
     TABLA = 265,
     CARGAR = 266,
     SUMA = 267,
     RESTA = 268,
     MULTIPLICACION = 269,
     DIVISION = 270,
     MODULO = 271,
     POTENCIA = 272,
     MAYOR_IGUAL = 273,
     MENOR_IGUAL = 274,
     IGUAL_IGUAL = 275,
     ASIGNAR = 276,
     NEGATIVO = 277
   };
#endif
/* Tokens.  */
#define NUMERO 258
#define NOMBRE_ARCHIVO 259
#define IDENTIFICADOR 260
#define AYUDA 261
#define SALIR 262
#define LIMPIAR 263
#define ESPACIO_TRABAJO 264
#define TABLA 265
#define CARGAR 266
#define SUMA 267
#define RESTA 268
#define MULTIPLICACION 269
#define DIVISION 270
#define MODULO 271
#define POTENCIA 272
#define MAYOR_IGUAL 273
#define MENOR_IGUAL 274
#define IGUAL_IGUAL 275
#define ASIGNAR 276
#define NEGATIVO 277




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 18 "pySintactico.y"
{
    char *cadena;
    float numero;
}
/* Line 1529 of yacc.c.  */
#line 98 "pySintactico.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

