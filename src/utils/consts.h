#ifndef __CONSTS_H_
#define __CONSTS_H_

/**
 * Enum holding all the possible operators in our language.
 */
enum Operator {
    OPR_ASSIGN = 100,       // a = b
    OPR_ADD,                // a + b
    OPR_U_PLUS,             // +54
    OPR_SUB,                // a - b
    OPR_U_MINUS,            // -54
    OPR_MUL,                // a * b
    OPR_DIV,                // a / b
    OPR_MOD,                // a % b
    OPR_PRE_INC,            // ++a
    OPR_SUF_INC,            // a++
    OPR_PRE_DEC,            // --a
    OPR_SUF_DEC,            // a--
    OPR_AND,                // a & b
    OPR_OR,                 // a | b
    OPR_XOR,                // a ^ b
    OPR_NOT,                // ~a
    OPR_SHL,                // a << 1
    OPR_SHR,                // a >> 1
    OPR_LOGICAL_AND,        // a && b
    OPR_LOGICAL_OR,         // a || b
    OPR_LOGICAL_NOT,        // !a
    OPR_GREATER,            // a > b
    OPR_GREATER_EQUAL,      // a >= b
    OPR_LESS,               // a < b
    OPR_LESS_EQUAL,         // a <= b
    OPR_EQUAL,              // a == b
    OPR_NOT_EQUAL,          // a != b

    //
    // Quadruples instructions
    //
	OPR_PUSH,				// PUSH X, push to the stack
	OPR_POP, 				// POP A, pop last element from the stack
};

/**
 * Enum holding all the possible data types in our language.
 * 
 * Note that order does matter.
 * DON'T CHANGE ENUM ORDER.
 */
enum DataType {
    DTYPE_BOOL  = 300,
    DTYPE_CHAR,
    DTYPE_INT,
    DTYPE_STRING,
    DTYPE_FLOAT,
    DTYPE_ERROR,
    DTYPE_UNKNOWN,
};

/**
 * Enum holding different scope types.
 */
enum ScopeType {
    SCOPE_BLOCK = 500,
    SCOPE_FUNCTION,
    SCOPE_LOOP,
    SCOPE_IF,
    SCOPE_SWITCH,
};

/**
 * Enum holding different logging levels.
 */
enum LogLevel {
    LOG_ERROR,
    LOG_WARNING,
    LOG_NOTE
};

#endif