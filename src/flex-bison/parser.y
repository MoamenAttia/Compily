%defines "parser.h"

%{
	#include <cmath>
	#include <cstdio>
	#include <iostream>
	// Variables and functions.
    #include "SyntaxTree/includes.h"
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
	Value		            iValue; 		// for the identifiers.
    Node*                   nPtr;
    IdentifierToken         identifierToken;
    DataType                dataType;
}


/*
// ----------------------------------------------------------------------------------- //
// TOKENS
*/

/* TERMINALS */

// Data types
%token INT
%token FLOAT
%token BOOL
%token STRING

// Keywords
%token CONST

// Operators
%token INC
%token DEC
%token AND
%token OR
%token EQUAL
%token NOT_EQUAL
%token GE
%token LE

// Identifers and values
%token <iValue> INTEGER_NUMBER
%token <iValue> FLOAT_NUMBER
%token <iValue> BOOL_VALUE
%token <iValue> STRING_VALUE
%token <identifierToken> IDENTIFIER


/* Syntax Tree */

%type <nPtr> expression stmt_list stmt variable_decl multi_variable_decl
%type <DataType> type;

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
    |               		stmt_list           { exit(0);  }
    ;

stmt_list: 					stmt                                { $$ = new StatementListNode($1, nullptr, false); }
	|						stmt_list stmt                      { $$ = new StatementListNode($2, $1, true); }
	;

stmt:						';'                                 { $$ = new StatementNode(nullptr, nullptr, nullptr, "", STMT_NOP); }
	|						expression ';'                      { $$ = new StatementNode($1, nullptr, nullptr, "", STMT_EXPRESSION_STMT); }
	|						variable_decl ';'                   { $$ = new StatementNode(nullptr, $1, nullptr, "", STMT_VAR_DEC); }
	|               		multi_variable_decl ';'             { $$ = new StatementNode(nullptr, nullptr, $1, "", STMT_MULTI_VAR_DEC); }
    |                       IDENTIFIER '=' expression           { $$ = new StatementNode($3, nullptr, nullptr, $1, STMT_IDENTIFIER_EXPRESSION); }
	;


variable_decl:           	type IDENTIFIER                                         { $$ = new VarDecNode($1, $2, false, nullptr, TYPE_ID); }
    |               		CONST type IDENTIFIER                                   { $$ = new VarDecNode($2, $3, true, nullptr, CONST_TYPE_ID); }
    |               		type IDENTIFIER '=' expression                          { $$ = new VarDecNode($1, $2, false, $4, TYPE_EXPRESSION); }
    |               		CONST type IDENTIFIER '=' expression                    { $$ = new VarDecNode($2, $3, true, $5, CONST_TYPE_EXPRESSION); }
    ;


multi_variable_decl:     	variable_decl ',' IDENTIFIER                            { $$ = new MultiVarNode($1, nullptr, nullptr, $3, VAR_DEC ); }
    |               		variable_decl ',' IDENTIFIER '=' expression             { $$ = new MultiVarNode($1, $5, nullptr, $3, VAR_DEC_INIT ); }
    |               		multi_variable_decl ',' IDENTIFIER                      { $$ = new MultiVarNode(nullptr, nullptr, $1, $3, MULTI_DEC ); }
    |               		multi_variable_decl ',' IDENTIFIER '=' expression       { $$ = new MultiVarNode(nullptr, $5, $1, $3, MULTI_DEC_INIT ); }
    ;



expression:                 expression '+' expression       { $$ = new BinaryOperationNode(PLUS, $1, $3); }
    |                       expression '-' expression       { $$ = new BinaryOperationNode(MINUS, $1, $3); }
    |                       expression '*' expression       { $$ = new BinaryOperationNode(MULTIPLICATION, $1, $3); }
    |                       expression '/' expression       { $$ = new BinaryOperationNode(DIVISION, $1, $3); }
    |                       expression '%' expression       { $$ = new BinaryOperationNode(MODOLUS, $1, $3); }
    |                       expression '&' expression       { $$ = new BinaryOperationNode(BITWISE_AND, $1, $3); }
    |                       expression '|' expression       { $$ = new BinaryOperationNode(BITWISE_OR, $1, $3); }
    |                       expression '^' expression       { $$ = new BinaryOperationNode(BITWISE_XOR, $1, $3); }
    |                       expression AND expression       { $$ = new BinaryOperationNode(AND, $1, $3); }
    |                       expression OR expression        { $$ = new BinaryOperationNode(OR, $1, $3); }
    |                       expression '>' expression       { $$ = new BinaryOperationNode(G, $1, $3); }
    |                       expression GE expression        { $$ = new BinaryOperationNode(GE, $1, $3); }
    |                       expression '<' expression       { $$ = new BinaryOperationNode(L, $1, $3); }
    |                       expression LE expression        { $$ = new BinaryOperationNode(LE, $1, $3); }
    |                       expression EQUAL expression     { $$ = new BinaryOperationNode(EQUAL, $1, $3); }
    |                       expression NOT_EQUAL expression { $$ = new BinaryOperationNode(NOT_EQUAL, $1, $3); }
    |                       '+' expression %prec U_PLUS     { $$ = new UnaryOperationNode(PLUS, $2); }
    |                       '-' expression %prec U_MINUM    { $$ = new UnaryOperationNode(MINUS, $2); }
    |                       '~' expression                  { $$ = new UnaryOperationNode(BITWISE_NOT, $2); }
    |                       '!' expression                  { $$ = new UnaryOperationNode(NOT, $2); }
    |                       '(' expression ')'              { Value val;  $$ = new ExpressionNode($2, RECURSIVE_EXPRESSION, val); }
    |                       INTEGER_NUMBER                  { Value val; val.intVal = $1; $$ = new ExpressionNode(nullptr, EXPRESSION_VALUE, val); }
    |                       FLOAT_NUMBER                    { Value val; val.floatVal = $1; $$ = new ExpressionNode(nullptr, EXPRESSION_VALUE, val); }
    |                       BOOL_VALUE                      { Value val; val.boolVal = $1; $$ = new ExpressionNode(nullptr, EXPRESSION_VALUE, val); }
    |                       STRING_VALUE                    { Value val; val.stringVal = $1; $$ = new ExpressionNode(nullptr, EXPRESSION_VALUE, val); }
    |                       IDENTIFIER                      { $$ = new IdentifierNode($1); }
    ;



type:                       INT                             { $$ = INT }
    |                       FLOAT                           { $$ = FLOAT }
    |                       BOOL                            { $$ = BOOL }
    |                       STRING                          { $$ = STRING }
    ;

%%
