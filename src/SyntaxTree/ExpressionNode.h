#pragma once

#include "Node.h"
#include "BinaryOperationNode.h"
#include "UnaryOperationNode.h"

class ExpressionNode : public Node
{
    BinaryOperationNode *binaryOperationNode;
    UnaryOperationNode *unaryOperationNode;
    ExpressionNodeEnum expType;
    ExpressionNode* expressionNode;
    Value val;

public:
    ExpressionNode(Node *node, ExpressionNodeEnum expType, DataType dataType, Value val)
    {
        this->expType = expType;
        switch (expType)
        {
        case BINARY_OPERATION:
            this->binaryOperationNode = (BinaryOperationNode*) node;
            break;
        case UNARY_OPERATION:
            this->unaryOperationNode = (UnaryOperationNode*) node;
            break;
        case RECURSIVE_EXPRESSION:
            this->expressionNode = expressionNode;
            break;
        case EXPRESSION_VALUE:
            this->val = val;
            break;
        default:
            break;
        }
    }

    ~ExpressionNode();
};
