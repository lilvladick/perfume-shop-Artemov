#ifndef PGCONNECTION_H
#define PGCONNECTION_H

#include <memory>
#include <mutex>
#include <libpq-fe.h>

class PGConnection
{
public:
    PGConnection();
    std::shared_ptr<PGconn> connection() const;

private:
    void establish_connection();

    std::string m_dbhost = "82.179.140.18";
    int         m_dbport = 5432;
    std::string m_dbname = "p2206_perfume_shop";
    std::string m_dbuser = "mpi";
    std::string m_dbpass = "135a1";

    std::shared_ptr<PGconn>  m_connection;

};


#endif //PGCONNECTION_H