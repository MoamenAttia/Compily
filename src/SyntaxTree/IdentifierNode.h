#pragma once

#include "Node.h"
#include "ExpressionNode.h"

class IdentifierNode: public Node
{

private:

    string name;

public:

    IdentifierNode(string name) {
        this->name = name;
    }

    ~IdentifierNode() {}

};
