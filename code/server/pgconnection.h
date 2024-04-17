#ifndef PGCONNECTION_H
#define PGCONNECTION_H

#include <stdio.h>
#include <libpq-fe.h>
#include <malloc.h>
#include <stdlib.h>

typedef struct {
    int ntuples;
    int nfields; 
    char*** values; 
    char** column_names; 
} QueryResult;

QueryResult* makeQuery(char* query);

void printQueryResult(QueryResult *queryRes);

#endif 