#include "erproc.h"

// Обработка ошибок
int handle_error(const char* msg) {
    perror(msg);
    return -1;
}

// Создание сокета
int Socket(int domain, int type, int protocol) {
    int res = socket(domain, type, protocol);
    if (res == -1) {
        handle_error("Socket failed");
    }
    return res;
}

// Привязка сокета
void Bind(int fd, const struct sockaddr *addr, socklen_t addrLen) {
    int res = bind(fd, addr, addrLen);
    if (res == -1) {
        handle_error("Bind failed");
    }
}

// Прослушивание сокета
int Listen(int fd, int backlog) {
    int res = listen(fd, backlog);
    if (res == -1) {
        handle_error("Listen failed");
    }
    return res;
}

// Принятие соединения
int Accept(int fd, struct sockaddr *addr, socklen_t *addrLen) {
    int res = accept(fd, addr, addrLen);
    if (res == -1) {
        handle_error("Accept failed");
    }
    return res;
}