#include "zmalloc.h"
#include "sds.h"

void init(void) __attribute__((constructor));
void cleanup(void) __attribute__((destructor));

void init(void) {
    printf("==== INIT ====\n");
}

void cleanup(void) {
    printf("==== CLEANUP ====\n");
}

void my_free(void *p) {
    printf("MY FREE: %p\n", p);
}

void *fn(void) {
    return malloc(10);
}

int main(void) {
    printf("MAIN START\n");

    {
        auto_free_ptr char *p = zmalloc(10);
        printf("p: %p\n", p);
        auto_close_file FILE *fp = fopen("main.c", "r");
        printf("fp: %p\n", fp);
        auto_free(my_free) int a;
        printf("a: %p\n", &a);
        auto_free_sds sds s = sdsnew("hello world");
        printf("sds: %p\n", s);
        auto_free_ptr char *pp = fn();
        printf("--pp: %p\n", pp);
    }

    printf("MAIN END\n");
    return 0;
}
