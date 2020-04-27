#include "../includes.h"
#include "../../context/scope_context.h"

bool ErrorNode::analyze(ScopeContext *context)
{
    context->log(what, loc, LOG_ERROR);
    return false;
}

bool BlockNode::analyze(ScopeContext *context)
{
    bool ret = true;
    context->addScope(SCOPE_BLOCK, this);
    for (int i = 0; i < statements.size(); ++i)
    {
        ret &= statements[i]->analyze(context);
    }
    context->popScope();
    return ret;
}

bool VarDeclarationNode::analyze(ScopeContext *context)
{
    bool ret = true;
    if (!context->declareSymbol(this))
    {
        context->log("'" + declaredHeader() + "' redeclared", ident->loc, LOG_ERROR);
        ret = false;
    }
    if (value)
    {
        ValueNode *ptr = dynamic_cast<ValueNode *>(value);
        if (ptr)
        {
            if (type->type != ptr->type)
            {
                context->log("type missmatch: cannot cast " + Utils::dtypeToStr(ptr->type) + " to " + Utils::dtypeToStr(type->type), ident->loc, LOG_ERROR);
                return false;
            }
        }
        IdentifierNode *ptr2 = dynamic_cast<IdentifierNode *>(value);
        if (ptr2)
        {
            DeclarationNode *node = context->getSymbol(ptr2->name);
            if (node)
            {
                if (type->type != node->type->type)
                {
                    context->log("type missmatch: cannot cast " + Utils::dtypeToStr(node->type->type) + " to " + Utils::dtypeToStr(type->type), ident->loc, LOG_ERROR);
                    return false;
                }
            }
        }
    }
    if (value)
    {
        context->initializeVar = true;
        ret &= value->analyze(context, true);
        context->initializeVar = false;
    }

    if (constant && value == NULL)
    {
        context->log("uninitialized const '" + ident->name + "'", ident->loc, LOG_ERROR);
        ret = false;
    }
    return ret;
}

bool MultiVarDeclarationNode::analyze(ScopeContext *context)
{
    int ret = true;

    for (int i = 0; i < vars.size(); ++i)
    {
        ret &= vars[i]->analyze(context);
    }

    return ret;
}