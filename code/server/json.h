#ifndef JSON_H
#define JSON_H

#include "pgconnection.h"
#include <cjson/cJSON.h>

cJSON* queryResultToJSON(QueryResult* result);

#endif