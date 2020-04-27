#include "../includes.h"
#include "../../context/generation_context.h"

string AssignOprNode::generateQuad(GenerationContext *context)
{
    string lhs_string = lhs->generateQuad(context);
    string rhs_string = rhs->generateQuad(context);
    string opr_string = "=";
    return opr_string + ' ' + rhs_string + ' ' + lhs_string + '\n';
}

string BinaryOprNode::generateQuad(GenerationContext *context)
{
    string ret;
    DataType t = max(lhs->type, rhs->type);
    string opr_string = Utils::oprToStr(opr);
    string left_operand = lhs->generateQuad(context);
    string left_temp_reg = "";
    bool done = false;
    for (int i = 0; i < left_operand.size(); ++i) {
        if(done) {
            ret += left_operand[i];
            continue;
        }
        if (left_operand[i] == ' ') {
            done = true;
            continue;
        }
        left_temp_reg += left_operand[i];
    }
    done = false;
    string right_operand = rhs->generateQuad(context);
    string right_temp_reg = "";
    for (int i = 0; i < right_operand.size(); ++i) {
        if(done) {
            ret += right_operand[i];
            continue;
        }
        if (right_operand[i] == ' ') {
            done = true;
            continue;
        }
        right_temp_reg += right_operand[i];
    }
    string temp_reg = context->getTempReg();
    return temp_reg + " " + ret + opr_string + ' ' + left_temp_reg + ' ' + right_temp_reg + ' ' + temp_reg + '\n';
}

string UnaryOprNode::generateQuad(GenerationContext *context)
{
    string opr_string = Utils::oprToStr(opr);
    string operand = expr->generateQuad(context);
    string temp_reg = context->getTempReg();
    return temp_reg + " " + opr_string + ' ' + operand + ' ' + '#' + ' ' + temp_reg + '\n';
}

string IdentifierNode::generateQuad(GenerationContext *context)
{
    return name;
}

string ValueNode::generateQuad(GenerationContext *context)
{
    return value;
}