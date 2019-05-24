.PHONY: all clean rebuild

OS = $(shell luvit -e "print(require('ffi').os)")
ARCH = $(shell luvit -e "print(require('ffi').arch)")

CC = gcc

TARGET = built/$(OS)-$(ARCH)/lsqlite3.so
OBJECTS = lsqlite3.o sqlite3.o

OPTS = -O2 -Wall -Wextra -fPIC
LIBS = -lpthread -lm -ldl -llua5.1
LDFLAGS = -shared
CFLAGS = -I/usr/include/lua5.1/ '-DLSQLITE_VERSION="0.9.5"'

all: $(TARGET)

clean:
	rm -f $(OBJECTS)

rebuild: clean all

test: rebuild
	luvit -e "require '.'"

$(TARGET): $(OBJECTS)
	mkdir -p `dirname $(TARGET)`
	$(CC) $(OPTS) $(LIBS) $(LDFLAGS) $^ -o $@

%.o: lsqlite3/%.c
	$(CC) $(OPTS) $(LIBS) $(CFLAGS) -c $^ -o $@
