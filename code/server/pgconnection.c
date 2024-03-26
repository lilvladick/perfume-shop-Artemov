#include "pgconnection.h"

const char conninfo[] = "hostaddr=82.179.140.18 port=5432 dbname=p2206_perfume_shop user=mpi password=135a1";

void printQueryResult(QueryResult* queryRes) {
    // Выводим заголовок таблицы с именами столбцов
    printf(" ");
    for (int j = 0; j < queryRes->nfields; j++) {
        printf("%-15s ", queryRes->column_names[j]);
    }
    printf("\n");

    // Выводим разделительную строку между заголовком и данными
    for (int j = 0; j < queryRes->nfields; j++) {
        printf("--------------- ");
    }
    printf("\n");

    // Выводим данные
    for (int i = 0; i < queryRes->ntuples; i++) {
        for (int j = 0; j < queryRes->nfields; j++) {
            printf("%-15s ", queryRes->values[i][j]);
        }
        printf("\n");
    }
}

QueryResult* parse_pgresult(PGresult* res) {
    QueryResult* result = malloc(sizeof(QueryResult));
    result->ntuples = PQntuples(res);
    result->nfields = PQnfields(res);

    result->values = malloc(result->ntuples * sizeof(char*));
    result->column_names = malloc(result->nfields * sizeof(char*));

    for (int i = 0; i < result->ntuples; i++) {
        result->values[i] = malloc(result->nfields * sizeof(char*));
        for (int j = 0; j < result->nfields; j++) {
            result->values[i][j] = PQgetvalue(res, i, j);
            result->column_names[j] = PQfname(res, j);
        }
    }

    return result;
}

PGresult* begin(PGconn* conn) {
    PGresult* res = PQexec(conn, "BEGIN TRANSACTION");
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        fprintf(stderr, "BEGIN command failed: %s", PQerrorMessage(conn));
        PQclear(res);
        exit(1);
    }
    return res;
}

PGresult* commit(PGconn* conn) {
    return PQexec(conn, "COMMIT");
}

PGresult* rollback(PGconn* conn) {
    return PQexec(conn, "ROLLBACK TRANSACTION");
}

PGconn* createConnection() {
    PGconn* conn = PQconnectdb(conninfo);
    if (PQstatus(conn) != CONNECTION_OK) {
        fprintf(stderr, "Connection to database failed: %s", PQerrorMessage(conn));
        PQfinish(conn);
        exit(1);
    }
    return conn;
}

QueryResult* queryExec(PGconn* conn, char* query) {
    PGresult* res = PQexec(conn, query);
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        fprintf(stderr, "FETCH ALL failed: %s", PQerrorMessage(conn));
        PQclear(res);
        exit(1);
    }
    return parse_pgresult(res);
}

QueryResult* makeQuery(char* query) {
    PGconn* conn = createConnection();
    PGresult* res = begin(conn);
    QueryResult* queryRes = queryExec(conn, query);
    res = commit(conn);

    return queryRes;
}
