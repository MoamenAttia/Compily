#include <iostream>
#include <string>
#include <string.h>

#include "context/scope_context.h"
#include "context/generation_context.h"
#include "SyntaxTree/includes.h"
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

void writeToFile(string data, string filename, bool is_quadruple);

int main(int argc, char *argv[])
{
    inputFilename = string(argv[1]);

    // Construct context objects
    ScopeContext scopeContext(inputFilename, warn);
    GenerationContext genContext;

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
        writeToFile(programRoot->generateQuad(&genContext), outputFilename, true);
        writeToFile(scopeContext.getSymbolTableStr(), symbolTableFilename, false);
    }
    else
    {
        writeToFile("", outputFilename, false);
    }
    // Finalize and release allocated memory
    fclose(yyin);
    if (programRoot != NULL)
    {
        delete programRoot;
    }
    return 0;
}

void writeToFile(string data, string filename, bool is_quadruple)
{
    if (filename.empty()) {
        return;
    }
    ofstream fout(filename);
    if (!fout.is_open()) {
        cout << "Error in write\n";
        return;
    }
    string output;
    if(is_quadruple){
        for(int i = 0 ; i < data.size(); ++i){
            if(data[i] == ' ') output += "\t";
            else output += data[i];
        }
        fout << output << endl;
    } else {
        fout << data << endl;
    }
    fout.close();
}