#pragma once

// Enum for DataType in the language.
enum DataType {
    INT = 0,
    FLOAT,
    BOOL,
    STRING,
};

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
    G,           // >
    GE,  // >=
    L,              // <
    LE,     // <=
    EQUAL,                  // ==
    NOT_EQUAL,              // !=
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



// Enum for Expression Node
enum ExpressionNodeEnum {
    BINARY_OPERATION = 100,
    UNARY_OPERATION,
    RECURSIVE_EXPRESSION,
    EXPRESSION_VALUE,
};

enum MultiVarNodeEnum {
    VAR_DEC = 110,
    VAR_DEC_INIT,
    MULTI_DEC,
    MULTI_DEC_INIT
};

enum VarDecNodeEnum {
    TYPE_ID = 120,
    CONST_TYPE_ID,
    TYPE_EXPRESSION,
    CONST_TYPE_EXPRESSION
};


enum StatementNodeEnum {
    STMT_NOP = 130,
    STMT_EXPRESSION_STMT,
    STMT_VAR_DEC,
    STMT_MULTI_VAR_DEC,
    STMT_IDENTIFIER_EXPRESSION
};