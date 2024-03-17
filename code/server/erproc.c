#include "erproc.h"

int Socket(int domain, int type, int protocol) {
    int res = socket(domain, type, protocol);
    if (res == -1) {
        perror("Socket failed");
        exit(EXIT_FAILURE);
    }
    return res;
}

void Bind(int fd, const struct sockaddr *addr, socklen_t addrLen) {
    int res = bind(fd, addr, addrLen);
    if (res == -1) {
        perror("Bind failed");
        exit(EXIT_FAILURE);
    }
}

int Listen(int fd, int backlog) {
    int res = listen(fd, backlog);
    if (res == -1) {
        perror("Listen failed");
        exit(EXIT_FAILURE);
    }
    return res;
}

int Accept(int fd, struct sockaddr *addr, socklen_t *addrLen) {
    int res = accept(fd, addr, addrLen);
    if (res == -1) {
        perror("Accept failed");
        exit(EXIT_FAILURE);
    }
    return res;
}