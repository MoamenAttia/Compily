#pragma once

#include "Node.h"
#include "VarDecNode.h"
#include "MultiVarNode.h"

class StatementNode: public Node
{

private:
    ExpressionNode* expressionNode;
    string identifier;
    StatementNodeEnum statementNodeEnum;
    VarDecNode* varDecNode;
    MultiVarNode* multiVarNode;

public:

    StatementNode(ExpressionNode* expressionNode, VarDecNode* varDecNode, MultiVarNode* multiVarNode, string identifier, StatementNodeEnum statementNodeEnum) {
        this->statementNodeEnum = statementNodeEnum;
        switch (statementNodeEnum)
        {
        case STMT_NOP:
            break;
        case STMT_VAR_DEC:
            this->varDecNode = varDecNode;
            break;
        case STMT_EXPRESSION_STMT:
            this->expressionNode = expressionNode;
            break;
        case STMT_MULTI_VAR_DEC:
            this->multiVarNode = multiVarNode;
            break;
        case STMT_IDENTIFIER_EXPRESSION:
            this->expressionNode = expressionNode;
            this->identifier = identifier;
        default:
            break;
        }
    }

    ~StatementNode();
};
