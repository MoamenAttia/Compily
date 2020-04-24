%option noyywrap

%{
	#pragma warning (disable: 4005)
	#include <iostream>
	#include <cmath>
	#include <string>
	#include "utils/utils.h"
	#include "parser.h"

	using namespace std;
%}


%{
	// FUNCTIONS AND VARIABLES
	void consumeToken(string type);
	void yyerror(string s);

	Location curLoc;
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



NEW_LINE					"\n"

INVALID						.



%%

{INT}						{ consumeToken("INT"); return INT; }
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



[+-=*/%&|^~><!{}()[]\'\";]		{ consumeToken(string(yytext)); return *yytext; }
"&&"							{ consumeToken("AND"); }
"||"							{ consumeToken("OR"); }
">="							{ consumeToken("GE"); }
"<="							{ consumeToken("LE"); }
"!="							{ consumeToken("NE"); }
"=="							{ consumeToken("ISEQ"); }
"++"							{ consumeToken("INC"); }
"--"							{ consumeToken("DEC"); }


\n							{ curLoc.lineNo++; curLoc.colNo = 0; }
\t							{ curLoc.colNo += 4; }
" "							{ curLoc.colNo++; }


{INTEGER_NUMBER}			{ consumeToken("INTEGER_NUMBER"); yylval = atoi(yytext); }
{FLOAT_NUMBER}				{ consumeToken("FLOAT_NUMBER"); }

{FALSE}						{ consumeToken("FALSE"); }
{TRUE}						{ consumeToken("TRUE"); }

{IDENTIFIER}				{ consumeToken("IDENTIFIER"); return IDENTIFIER; }
{STRING_VALUE}				{ consumeToken("STRING_VALUE"); }
{COMMENT}					{ consumeToken("COMMENT"); }


{INVALID}					{ consumeToken("INVALID"); yyerror("Unknown Character"); }

%%

void yyerror(string s) {
	cout << "lexical error: " << s << ", at line: " << curLoc.lineNo << ", col: " << curLoc.colNo << endl;
}

void consumeToken(string type) {
	if(type == "\n"){
		curLoc.lineNo++;
		curLoc.colNo = 0;
	} else if(type == " "){
		curLoc.colNo += yyleng;
	} else if(type == "INVALID"){
		curLoc.colNo++;
	} else {
		curLoc.colNo += yyleng;
	}
}