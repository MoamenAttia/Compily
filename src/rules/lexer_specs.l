%{
#include <vector>
#include <string>

#include "../parse_tree/parse_tree.h"
#include "parser.hpp"

using namespace std;

// Functions prototypes
void saveLocation();
void saveToken();

// Global variables
Location curLoc = {1,0,0};
%}

%{
// =====================================================================================================
// Start States
// ============
%}

%s BLOCK_COMMENT

%{
// =====================================================================================================
// Pattern Definitions (Substitutions)
// ===================================
%}

DIGIT               [0-9]
INTEGER             [0-9]+
FLOAT               (([0-9]*\.[0-9]+)|([0-9]+\.[0-9]*))
EXP                 ([eE][-+]?{INTEGER})
REAL                ({INTEGER}{EXP}|{FLOAT}{EXP}?)
LETTER              [a-zA-Z_]
IDENTIFIER          {LETTER}({LETTER}|{DIGIT})*
LINE_COMMENT        "//"(.)*
STRING_VALUE	    (\"(.*)\")
CHAR_VALUE          (\'.\')

%%

%{
// =====================================================================================================
// Rules Section
// =============
%}

%{
// Token localization
%}
\n                                  curLoc.lineNum++; curLoc.pos = 0;
\r                                  ;
\t                                  curLoc.pos += 4;
" "                                 curLoc.pos++;

%{
// Data types
%}
"int"                      saveLocation(); return TYPE_INT;
"float"                    saveLocation(); return TYPE_FLOAT;
"bool"                     saveLocation(); return TYPE_BOOL;
"const"                    saveLocation(); return CONST;
"string"                   saveLocation(); return TYPE_STRING;
"char"                     saveLocation(); return TYPE_CHAR;

%{
// Operators
%}

[-+*/%&|^~!<>=(){}[\],:;]  saveLocation(); return yytext[0];


%{
// Values
%}
{INTEGER}                  saveToken(); return INTEGER;
{REAL}                     saveToken(); return FLOAT;
(\'.\')                    saveToken(); return CHAR;
"true"                     saveToken(); return BOOL;
"false"                    saveToken(); return BOOL;
{IDENTIFIER}               saveToken(); return IDENTIFIER;
{STRING_VALUE}             saveToken(); return STRING_VALUE;

%{
// Others
%}

.                          saveLocation(); return yytext[0];

%%

void saveLocation() {
    curLoc.len = yyleng;

    yylval.location = curLoc;
    yylval.location.pos++;

    curLoc.pos += yyleng;
}

void saveToken() {
    curLoc.len = yyleng;

    yylval.token.value = strdup(yytext);
    yylval.token.loc = curLoc;
    yylval.token.loc.pos++;

    curLoc.pos += yyleng;
}

int yywrap() {
    return 1;
}