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
     HELP = 261,
     EXIT = 262,
     CLEAR = 263,
     WORKSPACE = 264,
     LOAD = 265,
     SUMA = 266,
     RESTA = 267,
     MULTIPLICACION = 268,
     DIVISION = 269,
     MODULO = 270,
     POTENCIA = 271,
     MAYOR_IGUAL = 272,
     MENOR_IGUAL = 273,
     IGUAL_IGUAL = 274,
     ASIGNAR = 275
   };
#endif
/* Tokens.  */
#define NUMERO 258
#define NOMBRE_ARCHIVO 259
#define IDENTIFICADOR 260
#define HELP 261
#define EXIT 262
#define CLEAR 263
#define WORKSPACE 264
#define LOAD 265
#define SUMA 266
#define RESTA 267
#define MULTIPLICACION 268
#define DIVISION 269
#define MODULO 270
#define POTENCIA 271
#define MAYOR_IGUAL 272
#define MENOR_IGUAL 273
#define IGUAL_IGUAL 274
#define ASIGNAR 275




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 18 "pySintactico.y"
{
    char *cadena;
    float numero;
}
/* Line 1529 of yacc.c.  */
#line 94 "pySintactico.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

