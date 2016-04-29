

all : clean snazzle
	@echo "\n==> Entrada que sera utilizada [entrada.txt]";
	@cat entrada.txt;
	@echo "\n==> Executando programa usando arquivo entrada.txt";
	./calculadora < entrada.txt

# Faz a compilacao do codigo em C++, porem precisa que exista o output do flex
snazzle: lex.yy.c calculadora.tab.c calculadora.tab.h
	@echo "\n==> Compilando...";
	gcc calculadora.tab.c lex.yy.c -o calculadora

# Gera codigo a partar da especificacao do flex
lex.yy.c:
	@echo "\n==> Executando FLEX para gerar código em linguagem C";
	snazzle.lex; flex -l calculadora.lex

calculadora.tab.c: calculadora.y
	@echo "\n==> Executando BISON para gerar código em linguagem C";
	bison -d calculadora.y

# regra util para limpar os arquivos que o make gera automaticamente
clean:
	@echo "\n==> Removendo arquivos desnecessários";
	rm -rf lex.yy.c calculadora.tab.h calculadora.tab.c calculadora lex.yy.o calculadora.tab.o
