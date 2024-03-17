#include <stdlib.h>
#include <sys/socket.h>
#include <stdio.h>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <errno.h>
#include <string.h>
#include "erproc.h"
#include "httpd.h"
#include "pg.h"

int main() {
    int server = Socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in adr = {0};
    adr.sin_family = AF_INET;
    adr.sin_port = htons(25522);
    Bind(server, (struct sockaddr *) &adr, sizeof adr);

    Listen(server, 5);

    socklen_t adrlen = sizeof adr;
    int fd = Accept(server, (struct sockaddr *) &adr, &adrlen);

    ssize_t nread;
    char buf[256];
    nread = read(fd, buf, 256);
    if (nread == -1) {
        perror("Read failed");
        exit(EXIT_FAILURE);
    }
    if (nread == 0) {
        printf("End of file occured\n");
    }

    write(STDOUT_FILENO, buf, nread);
    write(fd, buf, nread);

    sleep(1);

    close(fd);
    close(server);

    printf("BYE BYE");

    return 0;
}