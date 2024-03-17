#ifndef ERPROC_H
#define ERPROC_H

#include <stdlib.h>
#include <sys/socket.h>
#include <stdio.h>

int Socket(int domain, int type, int protocol);

void Bind(int fd, const struct sockaddr *addr, socklen_t addrlen);

int Listen(int fd, int backlog);

int Accept(int fd, struct sockaddr *addr, socklen_t *addrLen);

#endif
