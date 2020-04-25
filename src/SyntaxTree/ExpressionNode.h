#pragma once

#include "Node.h"
#include "BinaryOperationNode.h"
#include "UnaryOperationNode.h"

class ExpressionNode : public Node
{

protected:
    BinaryOperationNode *binaryOperationNode;
    UnaryOperationNode *unaryOperationNode;
    ExpressionNode *expressionNode;
    ExpressionNodeEnum expType;
    string identifier;

    int intVal;
    bool boolVal;
    float floatVal;
    string stringVal;

public:
    ExpressionNode() {}

    // Expression constructor for binary operation node.
    ExpressionNode(BinaryOperationNode *binaryOperationNode)
    {
        this->binaryOperationNode = binaryOperationNode;
        this->expType = EXPRESSION_BINARY_OPERATION;
    }

    // Expression constructor for unary operation node.
    ExpressionNode(UnaryOperationNode *unaryOperationNode)
    {
        this->unaryOperationNode = unaryOperationNode;
        this->expType = EXPRESSION_UNARY_OPERATION;
    }

    // Expression constructor for braces expression
    ExpressionNode(ExpressionNode *expressionNode)
    {
        this->expressionNode = expressionNode;
        this->expType = EXPRESSION_BRACES_EXPRESSION;
    }

    // Expression constructor for integer value
    ExpressionNode(int intVal)
    {
        this->intVal = intVal;
        this->expType = EXPRESSION_INT_VALUE;
    }

    // Expression constructor for float value
    ExpressionNode(float floatVal)
    {
        this->floatVal = floatVal;
        this->expType = EXPRESSION_FLOAT_VALUE;
    }

    // Expression constructor for boolean value
    ExpressionNode(bool boolVal)
    {
        this->boolVal = boolVal;
        this->expType = EXPRESSION_BOOL_VALUE;
    }

    // Expression constructor for string value
    ExpressionNode(string stringVal)
    {
        this->stringVal = stringVal;
        this->expType = EXPRESSION_STRING_VALUE;
    }

    ExpressionNode(string identifier, bool isIdentifier)
    {
        this->identifier = identifier;
        this->expType = EXPRESSION_IDENTIFIER;
    }

    ~ExpressionNode();
};
