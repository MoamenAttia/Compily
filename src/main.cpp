#include <iostream>
#include "parser.h"
using namespace std;

extern int yyparse();
extern FILE* yyin;

int main(int argc, char *argv[]) {
	yyin = fopen(argv[1], "r");
	if(yyin == NULL) {
		cout << "please select a valid file name\n";
		exit(0);
	}
	yyparse();
	fclose(yyin);
	return 0;
}

// we have to code this function
void yyerror(const char* msg) {
	cout << "Error: " << msg << endl;
}