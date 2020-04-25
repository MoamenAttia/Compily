#pragma once


// Enum for DataType in the language.

enum DataType {
    INT = 0,
    FLOAT,
    CHAR,
    BOOL,
    STRING,
    VOID,
};

// Enum for Control Flow

enum ControlFlow {
    IF = 10,
    ELSE,
    SWITCH,
    CASE,
    WHILE,
    DO,
    FOR,
    CONTINUE,
    BREAK,
    RETURN,
    DEFAULT,
};

// Enum for operators https://www.geeksforgeeks.org/operators-c-c/

enum Operator {
    PLUS = 30,              // +
    MINUS,                  // -
    ASSIGN,                 // =
    MULTIPLICATION,         // *
    DIVISION,               // /
    MODOLUS,                // %
    BITWISE_AND,            // &
    BITWISE_OR,             // |
    BITWISE_XOR,            // ^
    BITWISE_NOT,            // ~
    AND,                    // &&
    OR,                     // ||
    NOT,                    // !
    GREATER_THAN,           // >
    GREATER_THAN_OR_EQUAL,  // >=
    LESS_THAN,              // <
    LESS_THAN_OR_EQUAL,     // <=
    EQUAL,                  // ==
    NOT_EQUAL,              // !=
    INC,                    //"++"
    DEC,                    //"--"
};


// Enum for some reserved words https://www.tutorialspoint.com/Reserved-keywords-in-Cplusplus

enum ReservedWords {
    TRY = 80,
    CATCH,
    CONST,
    PUBLIC,
    PRIVATE,
    FALSE,
    TRUE,
    NEW,
    GOTO,
    THROW,
};