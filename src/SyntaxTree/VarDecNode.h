#pragma once

#include "Node.h"
#include "ExpressionNode.h"

class VarDecNode: public Node
{
    DataType type;
    bool isConst;
    string identifier;
    ExpressionNode* expressionNode;
    VarDecNodeEnum varDecEnum;


public:
    VarDecNode(DataType type, string identifier, bool isConst, ExpressionNode* expressionNode, VarDecNodeEnum varDecEnum) {
        this->type = type;
        this->identifier = identifier;
        this->isConst = isConst;
        switch (varDecEnum)
        {
        case TYPE_EXPRESSION:
            this->expressionNode = expressionNode;
            break;
        case CONST_TYPE_EXPRESSION:
            this->expressionNode = expressionNode;
            break;
        default:
            break;
        }
    }
    ~VarDecNode();
};
