clear:
	clear

gen:
	flex -o src/rules/lexer.cpp src/rules/lexer.l
	bison -d -o src/rules/parser.cpp src/rules/parser.y

compile:
	g++ -g -o compily.out \
		src/main.cpp \
		src/SyntaxTree/StatementNodes/StatementAnalyzer.cpp \
		src/SyntaxTree/StatementNodes/StatementGenerator.cpp \
		src/SyntaxTree/ExpressionNodes/ExpAnalyzer.cpp \
		src/SyntaxTree/ExpressionNodes/ExpEval.cpp \
		src/SyntaxTree/ExpressionNodes/ExpGen.cpp \
		src/rules/lexer.cpp \
		src/rules/parser.cpp
run:
	@make -s clear
	./compily.out tests/test_case_1.cpp

all:
	@make -s clear
	@make -s gen
	@make -s compile
	@make -s run


comp_test1:
	@make -s clear
	./compily.out tests/test_case_1.cpp

comp_test2:
	@make -s clear
	./compily.out tests/test_case_2.cpp

comp_test3:
	@make -s clear
	./compily.out tests/test_case_3.cpp

test1:
	@make -s clear
	@make -s gen
	@make -s compile
	@make -s comp_test1


test2:
	@make -s clear
	@make -s gen
	@make -s compile
	@make -s comp_test2


test3:
	@make -s clear
	@make -s gen
	@make -s compile
	@make -s comp_test3
