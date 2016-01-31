PROGRAM = iniread
LEXER   = lexer
PARSER  = parser
OBJS    = main.o $(PARSER).o $(LEXER).o

CC     = g++
YACC   = bison
LEX    = flex
LDLIBS = -lfl
YFLAGS = -dy -v -t

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(LINK.o) $^ $(LDLIBS) -o $@

main.o : $(PARSER).o
main.o : CPPFLAGS += -std=c++11

-include *.d
.PHONY:clean
clean:
	rm -rf $(PROGRAM) $(OBJS) $(PARSER).[co] $(LEXER).[co] y.tab.* y.output *.d core
