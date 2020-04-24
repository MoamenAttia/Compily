all:
	bison -o parser.cpp flex-bison/parser.y
	flex -o  lexer.cpp flex-bison/lexer.l
	g++ -o compily.o main.cpp lexer.cpp parser.cpp
	./compily.o tests/example.cpp
clean:
	rm lexer.cpp parser.cpp parser.h
	clear
