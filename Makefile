clear:
	clear

copy:
	cp -r  src/* out/

gen:
	flex -o out/rules/lexer.cpp out/rules/lexer_specs.l
	bison -d -o out/rules/parser.cpp out/rules/parser_grammar.y

comp:
	g++ -g -o out/compily.out \
		out/main.cpp \
		out/parse_tree/statements/statement_analyzer.cpp \
		out/parse_tree/statements/statement_generator.cpp \
		out/parse_tree/expressions/expression_analyzer.cpp \
		out/parse_tree/expressions/expression_generator.cpp \
		out/parse_tree/expressions/expression_evaluator.cpp \
		out/rules/lexer.cpp \
		out/rules/parser.cpp
build:
	@make -s clear
	@make -s copy
	@make -s gen
	@make -s comp
run:
	@make -s clear
	./out/compily.out tests/test_case0.cpp -o tests/out.quad -s tests/symbol_table.txt

all:
	@make -s build
	@make -s run