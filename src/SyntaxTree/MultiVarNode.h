#pragma once

#include "Node.h"
#include "VarDecNode.h"

class MultiVarNode : public Node
{
    VarDecNode *varDecNode;
    string identifer;
    ExpressionNode *expressionNode;
    MultiVarNode *multiVarNode;
    MultiVarNodeEnum multiVarNodeEnum;

public:
    MultiVarNode(VarDecNode *varDecNode, ExpressionNode *expressionNode, MultiVarNode *multiVarNode, string identifier, MultiVarNodeEnum multiVarNodeEnum)
    {
        this->multiVarNodeEnum = multiVarNodeEnum;
        this->identifer = identifer;
        switch (multiVarNodeEnum)
        {
        case VAR_DEC:
            this->varDecNode = varDecNode;
            break;
        case VAR_DEC_INIT:
            this->varDecNode = varDecNode;
            this->expressionNode = expressionNode;
            break;
        case MULTI_DEC:
            this->multiVarNode = multiVarNode;
            break;
        case MULTI_DEC_INIT:
            this->multiVarNode = multiVarNode;
            this->expressionNode = expressionNode;
        default:
            break;
        }
    }
    ~MultiVarNode();
};