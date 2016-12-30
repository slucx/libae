# libae from Redis

LIB_SHARED := libae.so
LIB_STATIC := libae.a

CC := gcc
AR := ar cr
CFLAGS := -Wall -fPIC -O2

OBJ_MEM := zmalloc.o
OBJ_AE := ae.o
OBJ_ANET := anet.o endianconv.o
OBJ_ALGO := sds.o adlist.o dict.o skiplist.o pqsort.o
OBJ_UTIL := sha1.o crc16.o crc64.o util.o

.msg:
	@echo ""
	@echo "Hint: libae from Redis"
	@echo ""

%.o: %.c .msg
	$(CC) $(CFLAGS) -c $<

all: $(OBJ_MEM) $(OBJ_AE) $(OBJ_ANET) $(OBJ_ALGO) $(OBJ_UTIL)
	$(CC) $(CFLAGS) -shared -o $(LIB_SHARED) $^
	$(AR) -o $(LIB_STATIC) $^

clean:
	-(rm -rf *.o)
	-(rm -rf .make-*)

distclean:
	make clean
	-(rm -rf $(LIB_SHARED) $(LIB_STATIC))

.PHONY: all clean distclean
