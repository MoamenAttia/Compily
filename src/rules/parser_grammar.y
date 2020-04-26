%{
#include <iostream>
#include <string>

#include "../parse_tree/parse_tree.h"

using namespace std;

//
// External functions & variables
//
extern int yylex();
extern Location curLoc;

//
// Functions prototypes
//
void yyerror(const char* s);

//
// Global variables
//
StatementNode* programRoot = NULL;
%}

// =====================================================================================================
// Symbol Types
// ============

%union {
    BlockNode*                  blockNode;
    StatementNode*              stmtNode;
    VarDeclarationNode*         varDeclNode;
    MultiVarDeclarationNode*    multiVarDeclNode;
    ExpressionNode*             exprNode;
    TypeNode*                   typeNode;
    ValueNode*                  valueNode;
    IdentifierNode*             identifierNode;
    StmtList*                   stmtList;
    Token                       token;
    Location                    location;
}

// =====================================================================================================
// Tokens Definition
// =================

// Data types
%token <location> TYPE_INT
%token <location> TYPE_FLOAT
%token <location> TYPE_BOOL
%token <location> TYPE_STRING

// Keywords
%token <location> CONST

// Values
%token <token> INTEGER
%token <token> FLOAT
%token <token> CHAR
%token <token> BOOL
%token <token> IDENTIFIER
%token <token> STRING_VALUE

// =====================================================================================================
// Non-terminal Symbols Types
// ==========================

%type <blockNode>           program
%type <stmtNode>            stmt
%type <stmtList>            stmt_list
%type <varDeclNode>         var_decl
%type <multiVarDeclNode>    multi_var_decl
%type <exprNode>            expression
%type <typeNode>            type
%type <valueNode>           value
%type <identifierNode>      ident

%type <location>            '-' '+' '*' '/' '%' '&' '|' '^' '~' '!' '<' '>' '=' '(' ')' '{' '}' '[' ']' ',' ':' ';'


// =====================================================================================================
// Precedence & Associativity
// ==========================

// Note that order matters here
%right      '='
%left       '-' '+'
%left       '*' '/'
%right      '!'
%right      U_PLUS U_MINUM

%%

// =====================================================================================================
// Rules Section
// =============

program:            %empty                      { $$ = NULL; programRoot = new BlockNode(); }
    |               stmt_list                   { $$ = NULL; programRoot = new BlockNode((*$1)[0]->loc, *$1); }
    ;

stmt_list:          stmt                        { $$ = new StmtList(); $$->push_back($1); }
    |               stmt_list stmt              { $$ = $1; $$->push_back($2); }
    ;

stmt:               ';'                         { $$ = new StatementNode($<location>1); }
    |               expression ';'              { $$ = $1; }
    |               var_decl ';'                { $$ = $1; }
    |               multi_var_decl ';'          { $$ = $1; }
    ;

// ------------------------------------------------------------
//
// Declaration Rules
//

var_decl:           type ident                              { $$ = new VarDeclarationNode($1, $2); }
    |               CONST type ident                        { $$ = new VarDeclarationNode($2, $3, NULL, true); }
    |               type ident '=' expression               { $$ = new VarDeclarationNode($1, $2, $4); }
    |               CONST type ident '=' expression         { $$ = new VarDeclarationNode($2, $3, $5, true); }
    ;

multi_var_decl:     var_decl ',' ident                      { $$ = new MultiVarDeclarationNode($1); $$->addVar($3); }
    |               var_decl ',' ident '=' expression       { $$ = new MultiVarDeclarationNode($1); $$->addVar($3, $5); }
    |               multi_var_decl ',' ident                { $$ = $1; $$->addVar($3); }
    |               multi_var_decl ',' ident '=' expression { $$ = $1; $$->addVar($3, $5); }

// ------------------------------------------------------------
//
// Expression Rules
//

expression:         expression '=' expression               { $$ = new AssignOprNode($2, $1, $3); }
    |               expression '+' expression               { $$ = new BinaryOprNode($2, OPR_ADD, $1, $3); }
    |               expression '-' expression               { $$ = new BinaryOprNode($2, OPR_SUB, $1, $3); }
    |               expression '*' expression               { $$ = new BinaryOprNode($2, OPR_MUL, $1, $3); }
    |               expression '/' expression               { $$ = new BinaryOprNode($2, OPR_DIV, $1, $3); }
    |               '+' expression %prec U_PLUS             { $$ = new UnaryOprNode($1, OPR_U_PLUS, $2); }
    |               '-' expression %prec U_MINUM            { $$ = new UnaryOprNode($1, OPR_U_MINUS, $2); }
    |               '!' expression                          { $$ = new UnaryOprNode($1, OPR_LOGICAL_NOT, $2); }
    |               value                                   { $$ = $1; }
    |               ident                                   { $$ = $1; }
    ;




// ------------------------------------------------------------
//
// Other Rules
//

type:               TYPE_INT        { $$ = new TypeNode($1, DTYPE_INT); }
    |               TYPE_FLOAT      { $$ = new TypeNode($1, DTYPE_FLOAT); }
    |               TYPE_BOOL       { $$ = new TypeNode($1, DTYPE_BOOL); }
    |               TYPE_STRING     { $$ = new TypeNode($1, DTYPE_STRING); }
    ;

value:              INTEGER         { $$ = new ValueNode($1.loc, DTYPE_INT, $1.value);  }
    |               FLOAT           { $$ = new ValueNode($1.loc, DTYPE_FLOAT, $1.value);  }
    |               CHAR            { $$ = new ValueNode($1.loc, DTYPE_CHAR, $1.value);  }
    |               BOOL            { $$ = new ValueNode($1.loc, DTYPE_BOOL, $1.value);  }
    |               STRING_VALUE    { $$ = new ValueNode($1.loc, DTYPE_STRING, $1.value); }
    ;

ident:              IDENTIFIER      { $$ = new IdentifierNode($1.loc, $1.value);  }
    ;

%%

void yyerror (char const *s)
{
   fprintf (stderr, "%s\n", s);
}