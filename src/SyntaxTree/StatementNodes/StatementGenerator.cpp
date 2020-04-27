#include "../includes.h"
#include "../../context/generation_context.h"

string BlockNode::generateQuad(GenerationContext *context)
{
    string ret;

    for (int i = 0; i < statements.size(); ++i)
    {
        ret += statements[i]->generateQuad(context);
    }

    return ret;
}

string VarDeclarationNode::generateQuad(GenerationContext *context)
{
    string ret;
    if (value)
    {
        string expr_quad = value->generateQuad(context);
        string temp_reg = "";
        bool done = false;
        for (int i = 0; i < expr_quad.size(); ++i)
        {
            if (done)
            {
                ret += expr_quad[i];
                continue;
            }
            if (expr_quad[i] == ' ')
            {
                done = true;
                continue;
            }
            temp_reg += expr_quad[i];
        }
        ret = ret + "= " + temp_reg + " " + "#" + " "  + ident->name + '\n';
    }
    return ret;
}

string MultiVarDeclarationNode::generateQuad(GenerationContext *context) { return ""; }