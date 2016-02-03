PROGRAM = iniread
LEXER   = lexer
PARSER  = parser
OBJS    = main.o api.o $(PARSER).o $(LEXER).o

CC     = g++
YACC   = bison
LEX    = flex
LDLIBS = -lfl
YFLAGS = -dy -v -t

main.o : CPPFLAGS += -std=c++11

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(LINK.o) $^ $(LDLIBS) -o $@

-include *.d
.PHONY:clean
clean:
	rm -rf $(PROGRAM) $(OBJS) $(PARSER).[co] $(LEXER).[co] y.tab.* y.output *.d core
