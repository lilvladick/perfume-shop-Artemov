#ifndef HTTP_H
#define HTTP_H

#include <string.h>
#include <unistd.h>
#include "pgconnection.h"
#include "json.h"

void handle_post(int fd, char* body);

void handle_not_found(int fd);

#endif