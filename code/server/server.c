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

static int _stopFlag = 0;
const static int _listenCount = 5;

int main(int argc, char** argv) {
    if (argc < 2) {
        fprintf(stdout, "Please, write correct port argument.\n");
        return 1;
    }
    char buf[2048];

    int server = Socket(AF_INET, SOCK_STREAM, 0);
    struct sockaddr_in adr = {0};
    adr.sin_family = AF_INET;
    adr.sin_port = htons(atoi(argv[1]));
    Bind(server, (struct sockaddr *) &adr, sizeof adr);
    socklen_t addrLen = sizeof adr;

    Listen(server, 5);
    fprintf(stdout, "Listening on port: %s \n", argv[1]);

    while (!_stopFlag) {
        pid_t pid;
        int fd;
        ssize_t nRead;
        
        if ((fd = Accept(server, (struct sockaddr *) &adr, &addrLen)) < 0 && errno != EINTR) {
            fprintf(stderr, "Unable to accept client: %s\n", strerror(errno));
        } else if (!_stopFlag) {
            fprintf(stdout, "Accepted client from %s\n", inet_ntoa(adr.sin_addr));
            
            nRead = read(fd, buf, sizeof(buf));
            if (nRead == -1) {
                perror("Read failed");
                exit(EXIT_FAILURE);
            }
            if (nRead == 0) {
                printf("End of file occurred\n");
            }
            buf[nRead] = '\0';

            // Парсим HTTP-запрос, извлекаем метод и URL
            char method[5];
            char url[128];
            sscanf(buf, "%4s %127s", method, url);
            char* body = strstr(buf, "\r\n\r\n");

            // Простой роутер для метода GET
            if (strncmp(method, "POST", 4) == 0 && body != NULL) {
                body += 4;
                if (strncmp(url, "/get_data", 9) == 0) {
                    handle_post(fd, body);
                } else {
                    handle_not_found(fd);
                }
            } else {
                // Добавьте обработку других методов или роутов по мере необходимости
                write(fd, "HTTP/1.1 405 Method Not Allowed\r\n\r\n", 35);
            }
            close(fd);
        }

    }

    sleep(1);

    close(server);

    printf("⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⣀⣠⣀⣀⣄⣀⣤⣀⣄⣠⣀⣄⣤⣿⣿⣿⣿⣿⣿⣿⣿⣟⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣘⣿⣿⣿⣿⣿⣿⣿⣿⣧⣄⣄⣀⣄⣀⣠⣀⣀⣄⣠⣠⣄⣄⡀
        ⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁
        ⠀⠀⠀⢹⣿⣿⡟⠋⠙⠉⠋⠙⠉⠋⠙⠉⣋⡙⠉⠋⠙⠉⠋⠙⠉⠋⠹⣿⣿⣿⣿⡟⠛⠙⠋⠛⠙⠋⠛⠉⠋⣙⡉⠋⠙⠉⠋⠙⠉⠋⠙⠙⣿⣿⣿⠁⠀⠀
        ⠀⠀⠀⠀⣿⣿⣿⠀⠀⢀⠂⠈⢠⠐⣥⢋⡴⣻⣿⡗⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣿⣷⠀⠀⠀⠠⠀⠈⢰⣟⣧⠀⠀⠀⠁⠀⠀⠀⡀⠀⠀⢠⣿⣿⡏⠀⠀⠀
        ⠀⠀⠀⠀⢿⣿⣿⡀⠀⠆⠀⠠⠸⠀⢼⣮⣿⢿⡽⣧⠀⢡⠀⠀⠀⢀⣿⣿⣿⣿⣿⣿⡆⠀⠀⡁⠐⠐⢸⡎⣽⣧⢀⠀⠀⠀⠁⠀⠀⠀⠀⣸⣿⣿⠃⠀⠀⠀
        ⠀⠀⠀⠀⠸⣿⣿⣇⠀⠀⠀⢰⣁⣬⡟⣿⢞⣯⣿⡷⣐⢦⠀⠀⠀⣸⣿⣿⣿⣿⣿⣿⣷⠀⠀⠈⢦⣕⡷⣭⣿⣾⡔⡌⠠⣄⠘⠀⠀⠀⠀⣿⣿⣿⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⣿⣿⣿⡀⠀⠀⠈⢛⡶⣽⢯⣿⣯⣿⣿⣽⠞⠀⠀⢀⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠘⢿⣿⣿⣿⣿⣿⣜⠷⢡⠊⠀⠀⠀⣰⣿⣿⡏⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠘⣿⣿⣷⣄⠀⠀⠀⠙⠫⢿⡿⣿⠿⠟⠁⠀⠀⣠⣾⣿⣿⡟⢣⠚⡽⣿⣿⣿⣆⡀⠀⠈⠹⢿⣿⣿⣿⠯⠛⠁⠀⠀⢀⣴⣿⣿⡿⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣷⣶⣤⣀⣀⣀⣀⣀⣀⣀⣠⣴⣾⣿⣿⣿⠟⠈⠀⠐⠈⠹⢿⣿⣿⣷⣦⣄⣀⣀⣠⣀⣀⣀⣀⣠⣤⣶⣿⣿⡿⠏⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠈⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠁⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠃⠀⠀⠀⡤⠉⠈⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⢉⡉⠁⠀⠀⠀⢠⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠘⠀⠀⠀⠈⠁⠀⠀⠀⠐⣝⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⢢⠀⠀⠸⠜⠀⠀⠀⠀⠄⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⢂⠀⠀⠀⠤⡀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣦⠖⠰⠀⠆⠰⠀⠆⠄⠲⠴⣶⣤⡀⠀⠀⠈⠃⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠑⠁⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⣿⣿⠇⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⢆⠀⠀⠀⠀⠀⠀⠀⠀⡸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡐⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠈⠒⠐⠂⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠔⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢡⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⡀⠄⢀⠠⠀⡀⠀⠄⡀⢀⠀⣀⠔⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠑⠠⢅⢂⠰⣀⠂⢄⠡⠈⠄⡐⠠⠐⣀⢂⡐⢠⢁⣒⡰⠜⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠤⣈⠗⣦⢯⣴⣌⣱⣌⣰⣡⣣⣔⣦⡼⣖⠫⠔⡠⢀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
        ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠐⠠⠉⠄⠓⠌⠫⢙⠋⠟⠹⢩⠟⠌⠱⠈⠁⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n
        server closed\n");

    return 0;
}