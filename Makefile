parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c lex.yy.c

y.tab.c y.tab.h: CS315_26S_Team1.yacc
	yacc -d -v CS315_26S_Team1.yacc

lex.yy.c: CS315_26S_Team1.lex y.tab.h
	flex CS315_26S_Team1.lex

clean:
	rm -f parser y.tab.c y.tab.h lex.yy.c y.output