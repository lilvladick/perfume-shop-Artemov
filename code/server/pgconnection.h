#ifndef PGCONNECTION_H
#define PGCONNECTION_H

#include <memory.h>
#include <mutex.h>
#include <libpq-fe.h>

typedef struct PGConnection
{
    char* dbhost;
    int dbport;
    char* dbname;
    char* dbuser;
    char* dbpass;
    PGconn* connection;
} PGConnection;

PGConnection* PGConnection_create();
PGconn* PGConnection_connection(const PGConnection* pgConn);
void PGConnection_destroy(PGConnection* pgConn);

#endif //PGCONNECTION_H