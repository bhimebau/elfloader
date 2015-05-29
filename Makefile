SRC=loader.c 
TARGET=libelfloader.a
INCLUDE=elfloader.h

CC=gcc
AS=gcc
LD=gcc
AR=ar

CFLAGS=-O3 -Wno-int-to-pointer-cast
LDFLAGS=

OBJS=$(SRC:.c=.o) 
DEPS=$(SRC:.c=.d)

all: $(TARGET)

-include $(DEPS)

$(TARGET): $(OBJS) 
	$(AR) rcs $@ $(OBJS) 

%.o: %.c
	@echo " CC $<"
	@$(CC) -MMD $(CFLAGS) -o $@ -c $<

.PHONY: clean all 

clean:
	@echo " CLEAN"
	@rm -fR $(OBJS) $(TARGET)

install: $(TARGET)
	cp $(TARGET) ../../lib 
	cp $(INCLUDE) ../../inc

etags:
	find . -type f -iname "*.[ch]" | xargs etags --append

