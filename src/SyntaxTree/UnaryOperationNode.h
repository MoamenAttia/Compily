#pragma once

#include "Node.h"
#include "ExpressionNode.h"

class UnaryOperationNode: public Node
{

private:

    Operator opr;
    ExpressionNode* operand;

public:

    UnaryOperationNode(Operator opr, ExpressionNode* operand) {
        this->opr = opr;
        this->operand = operand;
    }

    ~UnaryOperationNode() {
        if(operand) delete operand;
    }

};
