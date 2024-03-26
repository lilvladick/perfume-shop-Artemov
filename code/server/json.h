#ifndef JSON_H
#define JSON_H

#include "pgconnection.h"
#include <cJSON.h>

cJSON* queryResultToJSON(QueryResult* result);

#endif