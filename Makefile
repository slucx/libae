INSTALL := ./install
LIB_SHARED := libae.so
LIB_STATIC := libae.a

CC := gcc
AR := ar cr
CFLAGS := -Wall -Wextra -MMD -MP -fPIC -O2
LD_FLAGS := -lsqlite3

OBJ_MEM := zmalloc.o
OBJ_AE := ae.o
OBJ_ANET := anet.o endianconv.o
OBJ_ALGO := sds.o adlist.o dict.o skiplist.o pqsort.o
OBJ_UTIL := sha1.o crc16.o crc64.o util.o base64.o \
			cJSON.o json_wrap.o sqlite_wrap.o

%.o: %.c
	$(CC) $(CFLAGS) -c $<

all: $(LIB_SHARED) $(LIB_STATIC) test

test: main.c $(LIB_SHARED)
	$(CC) $(CFLAGS) -o ./test main.c $(LDFLAGS) -lae

$(LIB_SHARED): $(OBJ_MEM) $(OBJ_AE) $(OBJ_ANET) $(OBJ_ALGO) $(OBJ_UTIL)
	$(CC) $(CFLAGS) -shared -o $(LIB_SHARED) $^ $(LD_FLAGS)

$(LIB_STATIC): $(OBJ_MEM) $(OBJ_AE) $(OBJ_ANET) $(OBJ_ALGO) $(OBJ_UTIL)
	$(AR) $(LIB_STATIC) $^

install: $(LIB_STATIC) $(LIB_SHARED)
	-([ -d $(INSTALL) ] || mkdir $(INSTALL))
	-(cp $(LIB_STATIC) $(LIB_SHARED) *.h $(INSTALL))

clean:
	-(rm -rf *.o)
	-(rm -rf *.d)
	-(rm -rf .make-*)

distclean:
	make clean
	-(rm -rf $(LIB_SHARED) $(LIB_STATIC))
	-(rm -rf $(INSTALL))

.PHONY: all clean distclean install
