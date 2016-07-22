#change the name of the program here
NAME=main

#add extra cc file to compile here
EXTRA_SRC=

all: $(NAME)

LIBS=`pkg-config --libs libmym`
CFLAGS+=`pkg-config --cflags libmym`

#generate a list of object (.o) files
OBJS=$(patsubst %.c,%.o,$(NAME).c $(EXTRA_SRC))

#main program depend on all objects, rest is done by implicit rules
$(NAME): $(OBJS) .LDFLAGS
	${CC} ${LDFLAGS} -o ${NAME} ${OBJS} ${LIBS}

#clean up rule
clean:
	rm -f $(NAME) $(OBJS) .CFLAGS .LDFLAGS

dummy: ;

.%FLAGS: dummy
	@[ -f $@ ] || touch $@
	@echo "$*FLAGS=$($*FLAGS)" | cmp -s $@ - || echo "$*FLAGS=$($*FLAGS)" > $@

$(OBJS): .CFLAGS

#all, clean are phony rules, e.g. they should always run
.PHONY: all clean dummy
