# libae from Redis

INSTALL := ./install
LIB_SHARED := libae.so
LIB_STATIC := libae.a

CC := gcc
AR := ar cr
CFLAGS := -Wall -fPIC -O2

OBJ_MEM := zmalloc.o
OBJ_AE := ae.o
OBJ_ANET := anet.o endianconv.o
OBJ_ALGO := sds.o adlist.o dict.o skiplist.o pqsort.o
OBJ_UTIL := sha1.o crc16.o crc64.o util.o base64.o cJSON.o

%.o: %.c
	$(CC) $(CFLAGS) -c $<

all: $(LIB_SHARED) $(LIB_STATIC)

$(LIB_SHARED): $(OBJ_MEM) $(OBJ_AE) $(OBJ_ANET) $(OBJ_ALGO) $(OBJ_UTIL)
	$(CC) $(CFLAGS) -shared -o $(LIB_SHARED) $^

$(LIB_STATIC): $(OBJ_MEM) $(OBJ_AE) $(OBJ_ANET) $(OBJ_ALGO) $(OBJ_UTIL)
	$(AR) -o $(LIB_STATIC) $^

install: $(LIB_STATIC) $(LIB_SHARED)
	-([ -d $(INSTALL) ] || mkdir $(INSTALL))
	-(cp $(LIB_STATIC) $(LIB_SHARED) *.h $(INSTALL))

clean:
	-(rm -rf *.o)
	-(rm -rf .make-*)

distclean:
	make clean
	-(rm -rf $(LIB_SHARED) $(LIB_STATIC))
	-(rm -rf $(INSTALL))

.PHONY: all clean distclean install
