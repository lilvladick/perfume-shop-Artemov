#include "pgconnection.h"

PGConnection* createPGConnection() 
{
    PGConnection* connection = (PGConnection*)malloc(sizeof(PGConnection));
    if (connection == NULL) {
        return NULL;
    }
    
    connection->m_connection = PQsetdbLogin(connection->m_dbhost, 
                                            itoa(connection->m_dbport, connection->m_portStr, 10),
                                            NULL, NULL, 
                                            connection->m_dbname, 
                                            connection->m_dbuser, 
                                            connection->m_dbpass);

    if (PQstatus( connection->m_connection ) != CONNECTION_OK && PQsetnonblocking(connection->m_connection, 1) != 0 )
    {
       fprintf(stderr, "Error: %s\n", PQerrorMessage( connection->m_connection ));
       free(connection);
       return NULL;
    }
    
    return connection;
}

PGconn* getPGConnection(PGConnection* connection)
{
    return connection->m_connection;
}
