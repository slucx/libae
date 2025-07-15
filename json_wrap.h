#ifndef __JSON_WRAP_H
#define __JSON_WRAP_H

#include "cJSON.h"

cJSON *cJSON_Select(cJSON *o, const char *fmt, ...);

#endif
