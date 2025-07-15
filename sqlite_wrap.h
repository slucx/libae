#ifndef SQLITE_WRAPPER_H
#define SQLITE_WRAPPER_H

#include <stddef.h>
#include <stdint.h>
#include <sqlite3.h>

#include "sds.h"

#define SQL_MAX_SPEC 32     /* Maximum number of ?... specifiers per query. */

/* The sqlCol and sqlRow structures are used in order to return rows. */
typedef struct sqlCol {
    int type;
    int64_t i;          /* Integer or len of string/blob. */
    const char *s;      /* String or blob. */
    double d;           /* Double. */
} sqlCol;

typedef struct sqlRow {
    sqlite3_stmt *stmt; /* Handle for this query. */
    int cols;           /* Number of columns. */
    sqlCol *col;        /* Array of columns. Note that the first time this
                           will be NULL, so we now we don't need to call
                           sqlite3_step() since it was called by the
                           query function. */
} sqlRow;

/* Concatenate this when starting the bot and passing your create
 * DB query for Sqlite database initialization. */
#define TB_CREATE_KV_STORE \
    "CREATE TABLE IF NOT EXISTS KeyValue(expire INT, " \
                                        "key TEXT, " \
                                        "value BLOB);" \
    "CREATE UNIQUE INDEX IF NOT EXISTS idx_kv_key ON KeyValue(key);" \
    "CREATE INDEX IF NOT EXISTS idx_ex_key ON KeyValue(expire);"


int kvSetLen(sqlite3 *dbhandle, const char *key, const char *value, size_t vlen, int64_t expire);
int kvSet(sqlite3 *dbhandle, const char *key, const char *value, int64_t expire);
sds kvGet(sqlite3 *dbhandle, const char *key);
void kvDel(sqlite3 *dbhandle, const char *key);
void sqlEnd(sqlRow *row);
int sqlNextRow(sqlRow *row);
int sqlInsert(sqlite3 *dbhandle, const char *sql, ...);
int sqlQuery(sqlite3 *dbhandle, const char *sql, ...);
int sqlSelect(sqlite3 *dbhandle, sqlRow *row, const char *sql, ...);
int sqlSelectOneRow(sqlite3 *dbhandle, sqlRow *row, const char *sql, ...);
int64_t sqlSelectInt(sqlite3 *dbhandle, const char *sql, ...);

#endif
