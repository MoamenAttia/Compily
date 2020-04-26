#include "../parse_tree.h"
#include "../../context/scope_context.h"


bool ErrorNode::analyze(ScopeContext* context) {
    context->log(what, loc, LOG_ERROR);
    return false;
}

bool BlockNode::analyze(ScopeContext* context) {
    bool ret = true;
    context->addScope(SCOPE_BLOCK, this);
    for (int i = 0; i < statements.size(); ++i) {
        ret &= statements[i]->analyze(context);
    }
    context->popScope();
    return ret;
}

bool VarDeclarationNode::analyze(ScopeContext* context) {
    bool ret = true;
    if(value){
        if(value->type != ident->type){
            context->log("type missmatch: cannot cast " + value->exprTypeStr() + " to " + Utils::dtypeToStr(type->type), ident->loc, LOG_ERROR);
            return false;
        }
    }
    if (!context->declareSymbol(this)) {
        context->log("'" + declaredHeader() + "' redeclared", ident->loc, LOG_ERROR);
        ret = false;
    }
    if (value) {
        context->initializeVar = true;
        ret &= value->analyze(context, true);
        context->initializeVar = false;
    }

    if (constant && value == NULL) {
        context->log("uninitialized const '" + ident->name + "'", ident->loc, LOG_ERROR);
        ret = false;
    }
    return ret;
}

bool MultiVarDeclarationNode::analyze(ScopeContext* context) {
    int ret = true;

    for (int i = 0; i < vars.size(); ++i) {
        ret &= vars[i]->analyze(context);
    }

    return ret;
}