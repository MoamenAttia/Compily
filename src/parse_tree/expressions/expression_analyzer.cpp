#include "../parse_tree.h"
#include "../../context/scope_context.h"



bool AssignOprNode::analyze(ScopeContext* context, bool valueUsed) {
    if (!(rhs->analyze(context, true) & lhs->analyze(context, false))) {
        // Note that I used a bitwise AND to execute both lhs and rhs expressions
        return false;
    }


    if (lhs->reference == NULL) {
        context->log("lvalue required as left operand of assignment", lhs->loc, LOG_ERROR);
        return false;
    }
    if (lhs->reference && lhs->constant) {
        context->log("assignment of read-only variable '" + lhs->reference->declaredHeader() + "'", lhs->loc, LOG_ERROR);
        return false;
    }

    if(lhs->type != rhs->type) {
        context->log("type missmatch: cannot cast " + rhs->exprTypeStr() + " to " + lhs->exprTypeStr(), lhs->loc, LOG_ERROR);
        return false;
    }

    type = lhs->type;
    reference = lhs->reference;
    constant = lhs->constant;
    used = valueUsed;

    reference->initialized = true;

    return true;
}

bool BinaryOprNode::analyze(ScopeContext* context, bool valueUsed) {
    if (!(lhs->analyze(context, valueUsed) & rhs->analyze(context, valueUsed))) {
        // Note that I used a bitwise AND to execute both lhs and rhs expressions
        return false;
    }

    if (lhs->type != rhs->type) {
        context->log("invalid operands of types '" + lhs->exprTypeStr() + "' and '" + rhs->exprTypeStr() + "' to " +
                     getOpr(), loc, LOG_ERROR);
        return false;
    }

    type = max(lhs->type, rhs->type);

    constant = (lhs->constant && rhs->constant);
    used = valueUsed;

    return true;
}

bool UnaryOprNode::analyze(ScopeContext* context, bool valueUsed) {
    if (!expr->analyze(context, valueUsed)) {
        return false;
    }

    if (expr->type == DTYPE_FLOAT && Utils::isBitwiseOpr(opr)) {
        context->log("invalid operand of type '" + expr->exprTypeStr() + "' to " + getOpr(), loc, LOG_ERROR);
        return false;
    }

    type = expr->type;
    reference = NULL;
    constant = expr->constant;
    used = valueUsed;

    return true;
}

bool IdentifierNode::analyze(ScopeContext* context, bool valueUsed) {
    DeclarationNode* ptr = context->getSymbol(name);

    if (ptr == NULL) {
        context->log("'" + name + "' was not declared in this scope", loc, LOG_ERROR);
        return false;
    }

    reference = ptr;
    type = ptr->type->type;
    constant = ((VarDeclarationNode*) ptr)->constant;
    used = valueUsed;
    if (used) {
        reference->used++;
    }

    if (used && !reference->initialized) {
        context->log("variable or field '" + name + "' used without being initialized", loc, LOG_ERROR);
        return false;
    }

    return true;
}
