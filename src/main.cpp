#include <iostream>
#include <string>
#include <string.h>

#include "context/scope_context.h"
#include "context/generation_context.h"
#include "parse_tree/parse_tree.h"
#include "utils/utils.h"
#include "utils/consts.h"

using namespace std;

// External functions & variables
extern int yyparse();
extern FILE *yyin;
extern StatementNode *programRoot;

// Global Variables
string inputFilename;
string outputFilename = "out.o";
string symbolTableFilename;
bool warn = false;

void writeToFile(string data, string filename);

int main(int argc, char *argv[])
{
    // Construct context objects
    ScopeContext scopeContext(inputFilename, warn);
    GenerationContext genContext;
    inputFilename = string(argv[1]);

    string temp = "";
    if (inputFilename.size() > 5)
    { // {filename}.cpp
        for (int i = 0; i < inputFilename.size() - 4; ++i)
        {
            temp += inputFilename[i];
        }
    }

    // Open input file for Lex & Yacc
    yyin = fopen(inputFilename.c_str(), "r");

    if (yyin == NULL)
    {
        cout << "please enter a valid filename\n";
        exit(0);
    }

    // Construct the parse tree
    yyparse();

    outputFilename = temp + ".quadruples";
    symbolTableFilename = temp + ".sym";
    // Apply semantic check and quadruple generation
    if (programRoot != NULL && programRoot->analyze(&scopeContext))
    {
        writeToFile(programRoot->generateQuad(&genContext), outputFilename);
        writeToFile(scopeContext.getSymbolTableStr(), symbolTableFilename);
    }
    else
    {
        writeToFile("", outputFilename);
    }
    // Finalize and release allocated memory
    fclose(yyin);
    if (programRoot != NULL)
    {
        delete programRoot;
    }
    return 0;
}

void writeToFile(string data, string filename)
{
    if (filename.empty()) {
        return;
    }
    ofstream fout(filename);
    if (!fout.is_open()) {
        cout << "Error in write\n";
        return;
    }
    fout << data << endl;
    fout.close();
}