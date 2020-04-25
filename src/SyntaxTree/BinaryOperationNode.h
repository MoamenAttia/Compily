#pragma once

#include "Node.h"
#include "ExpressionNode.h"

class BinaryOperationNode: public Node
{

private:

    Operator opr;
    ExpressionNode* left;
    ExpressionNode* right;

public:

    BinaryOperationNode(Operator opr, ExpressionNode* left, ExpressionNode* right) {
        this->opr = opr;
        this->left = left;
        this->right = right;
    }

    ~BinaryOperationNode() {
        if(left) delete left;
        if(right) delete right;
    }

};
