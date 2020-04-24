%option noyywrap

%{
	#pragma warning (disable: 4005)
	#include <iostream>
	#include <cmath>
	#include <string>
	#include "utils/consts.h"
	#include "parser.h"

	using namespace std;
%}


%{
	// FUNCTIONS AND VARIABLES
	void consumeToken(string type);
	void yyerror(string s);


	int lineNumber = 1, cursor = 0;
%}


/* NOTE: Quotes String => to tell lex NOT interpret any special characters (eg, for regular expressions) in the quoted string */


/* https://www.petefreitag.com/cheatsheets/regex/ */

/*
// ----------------------------------------------------------------------------------- //
// DATATYPES
*/

INT							"int"
BOOL						"bool"
CHAR						"char"
FLOAT						"float"
VOID						"void"
STRING                      "string"

/*
// ----------------------------------------------------------------------------------- //
// CONTROL FLOW
*/

IF							"if"
ELSE						"else"
WHILE						"while"
FOR							"for"
SWITCH						"switch"
CASE						"case"
DEFAULT						"default"
DO							"do"
BREAK						"break"
CONTINUE					"continue"

/*
// ----------------------------------------------------------------------------------- //
// OPERATORS
*/


PLUS						"+"
MINUS						"-"
ASSIGN						"="
MULTIPLICATION				"*"
DIVISION					"/"
MODOLUS						"%"
BITWISE_AND					"&"
BITWISE_OR					"|"
BITWISE_XOR					"^"
BITWISE_NOT					"~"
AND							"&&"
OR							"||"
NOT							"!"
GREATER_THAN				">"
GREATER_THAN_OR_EQUAL		">="
LESS_THAN					"<"
LESS_THAN_OR_EQUAL			"<="
EQUAL						"=="
NOT_EQUAL					"!="
INC                         "++"
DEC                         "--"


/*
// ----------------------------------------------------------------------------------- //
// ARTHIMATIC
*/
DIGIT						[0-9]
INTEGER_NUMBER				{DIGIT}+
FLOAT_NUMBER				(({DIGIT}*\.{DIGIT}+)|({DIGIT}+\.{DIGIT}+))



/*
// ----------------------------------------------------------------------------------- //
// RESERVED WORDS
*/
CONST 						"const"
FALSE						"false"
TRUE						"true"


/*
// ----------------------------------------------------------------------------------- //
// IDENTIFIER
*/

CHARACTER					[_A-Za-z]
IDENTIFIER					({CHARACTER})({DIGIT}|{CHARACTER})*
WHITESPACE                  [ \t]+
STRING_VALUE				(\"(.*)\")
COMMENT						"//(.)*"


/*
// ----------------------------------------------------------------------------------- //
// SPECIALS
*/

LEFT_CURLY_BRACE			"{"
RIGHT_CURLY_BRACE			"}"
LEFT_PARENTHESES			"("
RIGHT_PARENTHESES			")"
LEFT_SQUARE_BRACKET			"["
RIGHT_SQUARE_BRACKET		"]"
SINGLE_QUOTE				(')
DOUBLE_QUOTE				"\""
SEMI_COLON					";"
NEW_LINE					"\n"
INVALID						.



%%

{INT}						{ consumeToken("INT"); }
{BOOL}						{ consumeToken("BOOL"); }
{CHAR}						{ consumeToken("CHAR"); }
{FLOAT}						{ consumeToken("FLOAT"); }
{CONST}						{ consumeToken("CONST"); }
{VOID}						{ consumeToken("VOID"); }
{STRING}					{ consumeToken("STRING"); }



{IF}						{ consumeToken("IF"); }
{ELSE}						{ consumeToken("ELSE"); }
{WHILE}						{ consumeToken("WHILE"); }
{FOR}						{ consumeToken("FOR"); }
{SWITCH}					{ consumeToken("SWITCH"); }
{CASE}						{ consumeToken("CASE"); }
{DEFAULT}					{ consumeToken("DEFAULt"); }
{DO}						{ consumeToken("DO"); }
{BREAK}						{ consumeToken("BREAK"); }
{CONTINUE}					{ consumeToken("CONTINUE"); }


{PLUS}						{ consumeToken("PLUS"); return '+'; }
{MINUS}						{ consumeToken("MINUS"); }
{ASSIGN}					{ consumeToken("ASSIGN"); }
{MULTIPLICATION}			{ consumeToken("MULTIPLICATION"); }
{DIVISION}					{ consumeToken("DIVISION"); }
{MODOLUS}					{ consumeToken("MODOLUS"); }
{BITWISE_AND}				{ consumeToken("BITWISE_AND"); }
{BITWISE_OR}				{ consumeToken("BITWISE_OR"); }
{BITWISE_XOR}				{ consumeToken("BITWISE_XOR"); }
{BITWISE_NOT}				{ consumeToken("BITWISE_NOT"); }
{AND}						{ consumeToken("AND"); }
{OR}						{ consumeToken("OR"); }
{NOT}						{ consumeToken("NOT"); }
{GREATER_THAN}				{ consumeToken("GREATER_THAN"); }
{GREATER_THAN_OR_EQUAL}		{ consumeToken("GREATER_THAN_OR_EQUAL"); }
{LESS_THAN}					{ consumeToken("LESS_THAN"); }
{LESS_THAN_OR_EQUAL}		{ consumeToken("LESS_THAN_OR_EQUAL"); }
{EQUAL}						{ consumeToken("EQUAL"); }
{NOT_EQUAL}					{ consumeToken("NOT_EQUAL"); }
{INC}						{ consumeToken("INC"); }
{DEC}						{ consumeToken("DEC"); }



{LEFT_CURLY_BRACE}			{ consumeToken("LEFT_CURLY_BRACE"); }
{RIGHT_CURLY_BRACE}			{ consumeToken("RIGHT_CURLY_BRACE"); }
{LEFT_PARENTHESES}			{ consumeToken("LEFT_PARENTHESES"); }
{RIGHT_PARENTHESES}			{ consumeToken("RIGHT_PARENTHESES"); }
{LEFT_SQUARE_BRACKET}		{ consumeToken("LEFT_SQUARE_BRACKET"); }
{RIGHT_SQUARE_BRACKET}		{ consumeToken("RIGHT_SQUARE_BRACKET"); }
{SINGLE_QUOTE}				{ consumeToken("SINGLE_QUOTE"); }
{DOUBLE_QUOTE}				{ consumeToken("DOUBLE_QUOTE"); }


{INTEGER_NUMBER}			{ consumeToken("INTEGER_NUMBER"); yylval = atoi(yytext); return INTEGER_NUMBER; }
{FLOAT_NUMBER}				{ consumeToken("FLOAT_NUMBER"); }

{CONST}						{ consumeToken("CONST"); }
{FALSE}						{ consumeToken("FALSE"); }
{TRUE}						{ consumeToken("TRUE"); }

{IDENTIFIER}				{ consumeToken("IDENTIFIER"); }
{STRING_VALUE}				{ consumeToken("STRING_VALUE"); }
{COMMENT}					{ consumeToken("COMMENT"); }

{NEW_LINE}					{ consumeToken("NEW_LINE"); }
{WHITESPACE}				{ consumeToken("WHITESPACE"); }


{INVALID}					{ consumeToken("INVALID"); yyerror("Unknown Character"); }

%%

void yyerror(string s) {
	cout << "lexical error: " << s << ", at line: " << lineNumber << ", col: " << cursor << endl;
}

void consumeToken(string type) {
	if(type == "NEW_LINE"){
		lineNumber++;
		cursor = 0;
	} else if(type == "WHITESPACE"){
		cursor += yyleng;
	} else if(type == "INVALID"){
		cursor++;
	} else {
		cursor += yyleng;
	}
}