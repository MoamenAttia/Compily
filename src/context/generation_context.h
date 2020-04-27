#ifndef __GENERATION_CONTEXT_H_
#define __GENERATION_CONTEXT_H_

#include <iostream>
#include <string>
#include <vector>
#include <stack>
#include <map>

using namespace std;

/**
 * Class holding the current context in the quadruple generation phase.
 */
class GenerationContext
{
public:
    stack<int> breakLabels, continueLabels;
    int labelCounter;
    int temp_cnt = 0; // counter of temp registers

    
    GenerationContext() { labelCounter = 1; }
    string getTempReg()
    {
        return "t" + to_string(temp_cnt++);
    }
};

#endif