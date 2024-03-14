#include "erproc.h"
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <unistd.h>
#include <arpa/inet.h>

int Socket(int domain, int type, int protocol) {
    int res = socket(domain, type, protocol);
    if (res == -1) {
        perror("Socket failed");
        exit(EXIT_FAILURE);
    }
    return res;
}

void Bind(int sockfd, const struct sockaddr *addr, socklen_t addrlen) {
    int res = bind(sockfd, addr, addrlen);
    if (res == -1) {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }
}

int Listen(int sockfd, int backlog) {
    int res = listen(sockfd, backlog);
    if (res == -1) {
        perror("Listen failed");
        exit(EXIT_FAILURE);
    }
    return res;
}

int Accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen) {
    int res = accept(sockfd, addr, addrlen);
    if (res == -1) {
        perror("Accept failed");
        exit(EXIT_FAILURE);
    }
    return res;
}

int Connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen) {
    int res = connect(sockfd, addr, addrlen);
    if (res == -1) {
        perror("Connection failed");
        exit(EXIT_FAILURE);
    }
    return res;
}

void Inet_pton(int af, const char *src, void *dst) {
    int res = inet_pton(af, src, dst);
    if (res == 0) {
        printf("inet_pton failed: stc does not contain a character"
        " string representing a valid network address in the specified"
        " address family\n");
        exit(EXIT_FAILURE);
    }
    if (res == -1) {
        perror("inet_pton failed");
        exit(EXIT_FAILURE);
    }
}
