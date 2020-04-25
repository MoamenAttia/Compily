#pragma once
#include <string>

// struct for the location of the cursor.
struct Location {
	int lineNo = 1;
	int colNo = 0;
};

// struct for the token holding the location and the name of the token.
struct IdentifierToken {
	string type; // type: int, float, ...
    string value; // value: 14, 14.04, ...
    Location loc;
};


// Union for the values.
struct Value {
    int intVal;
    float floatVal;
    bool booleanVal;
	string stringVal;
};



