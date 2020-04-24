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


%token INTEGER_NUMBER, NEW_LINE, IDENTIFIER, INT, PLUS, SEMI_COLON, ASSIGN

%%

program: INT IDENTIFIER ASSIGN IDENTIFIER PLUS IDENTIFIER SEMI_COLON
		;

%%
