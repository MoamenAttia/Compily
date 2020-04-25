#pragma once

#include "Node.h"
#include "VarDecNode.h"
#include "MultiVarNode.h"
#include "StatementNode.h"

class StatementListNode : public Node
{

private:
    StatementNode *statementNode;
    StatementListNode *statementListNode;
    bool isRecursive;

public:
    StatementListNode(StatementNode *statementNode, StatementListNode* statementListNode, bool isRecursive)
    {
        this->statementNode = statementNode;
        this->isRecursive = isRecursive;
        if (isRecursive)
        {
            this->statementListNode = statementListNode;
        }
    }

    ~StatementListNode();
};
