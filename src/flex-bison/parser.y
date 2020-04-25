%defines "parser.h"

%{
	#include <cmath>
	#include <cstdio>
	#include <iostream>
	#include "utils/utils.h"

	// Variables and functions.

	extern Location curLoc;
	extern int yylex();
	extern void yyerror(const char*);


	using namespace std;
%}


%token INT INTEGER_NUMBER NEW_LINE IDENTIFIER

%token '+' '-' '=' '*' '/' '%' '&' '|' '^' '~' '>' '<' '!' '{' '}' '(' ')' '[' ']' ';' '\'' '\"'

%%

program: INT IDENTIFIER '=' INTEGER_NUMBER ';'
		;

%%
