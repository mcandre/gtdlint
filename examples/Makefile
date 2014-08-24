CC=gcc # TODO: switch to clang
FLAGS=-O2 -Wall -Wextra # TO DO: Apply clang warnings

BIN=bin/hello

all: test

test: $(BIN)
	$(BIN)

$(BIN): hello.c
	mkdir -p bin/
	$(CC) $(FLAGS) -o $(BIN) hello.c

# todo linters (cppcheck, splint, vera++)
# todo valgrind

clean:
	-rm -rf bin/
