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



/*
// ----------------------------------------------------------------------------------- //
// yyval
*/

%union {
	Token		token; 		// for the identifiers.
    Location	location; 	// for the "int", "float", keywords, ....
}


/*
// ----------------------------------------------------------------------------------- //
// TOKENS
*/

/* TERMINALS */

// Data types
%token <location> INT
%token <location> FLOAT
%token <location> BOOL
%token <location> VOID

// Keywords
%token <location> CONST

// Operators
%token <location> INC
%token <location> DEC
%token <location> AND
%token <location> OR
%token <location> EQUAL
%token <location> NOT_EQUAL
%token <location> GE
%token <location> LE

// Identifers and values
%token <token> INTEGER_NUMBER
%token <token> FLOAT_NUMBER
%token <token> BOOL_VALUE
%token <token> STRING_VALUE
%token <token> IDENTIFIER


/* Syntax Tree */

%type <location> '+' '-' '=' '*' '/' '%' '&' '|' '^' '~' '>' '<' '!' '{' '}' '(' ')' '[' ']' ';' '\'' '\"'



/*
// ----------------------------------------------------------------------------------- //
// Precedence & Associativity
*/

%right      '='
%left       OR
%left       AND
%left       '|'
%left       '^'
%left       '&'
%left       EQUAL NOT_EQUAL
%left       LE GE '<' '>'
%left       '-' '+'
%left       '*' '/' '%'
%right      '!' '~'
%right      U_PLUS U_MINUM



%%

program:            		%empty
    |               		stmt_list
    ;

stmt_list: 					stmt
	|						'{' stmt_list '}'
	|						stmt_list stmt
	;


stmt:						';'
	|						expression ';'
	|						variable_decl ';'
	|               		multi_variable_decl ';'
	;

variable_decl:           	type IDENTIFIER
    |               		CONST type IDENTIFIER
    |               		type IDENTIFIER '=' expression
    |               		CONST type IDENTIFIER '=' expression
    ;


multi_variable_decl:     	var_decl ',' IDENTIFIER
    |               		var_decl ',' IDENTIFIER '=' expression
    |               		multi_variable_decl ',' IDENTIFIER
    |               		multi_variable_decl ',' IDENTIFIER '=' expression
    ;

expression:                 expression '=' expression
    |                       expression '+' expression
    |                       expression '-' expression
    |                       expression '*' expression
    |                       expression '/' expression
    |                       expression '%' expression
    |                       expression '&' expression
    |                       expression '|' expression
    |                       expression '^' expression
    |                       expression AND expression
    |                       expression OR expression
    |                       expression '>' expression
    |                       expression GE expression
    |                       expression '<' expression
    |                       expression LE expression
    |                       expression EQUAL expression
    |                       expression NOT_EQUAL expression
    |                       '+' expression %prec U_PLUS
    |                       '-' expression %prec U_MINUM
    |                       '~' expression
    |                       '!' expression
    |                       '(' expression ')'
    |                       value
    |                       IDENTIFIER
    ;



type:                       INT
    |                       FLOAT
    |                       BOOL
    |                       STRING
    ;

value:                      INTEGER_NUMBER
    |                       FLOAT_NUMBER
    |                       STRING_VALUE
    |                       BOOL_VALUE
    ;

%%
