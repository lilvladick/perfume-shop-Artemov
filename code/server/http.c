#include "http.h"

void handle_post(int fd, char *  body) {
    cJSON *  parsedBody = cJSON_Parse(body);
    cJSON *  query = cJSON_GetObjectItemCaseSensitive(parsedBody, "query");
    QueryResult  * result;
    cJSON  * jsonResponse;

    result = makeQuery(query->valuestring);
    jsonResponse = queryResultToJSON(result);

    // Отправка HTTP-заголовков
    const char  * headers = "HTTP/1.1 200 OK\r\n"
                          "Content-Type: application/json\r\n\r\n";
    write(fd, headers, strlen(headers));

    // Отправка JSON-ответа
    char  * jsonString = cJSON_Print(jsonResponse);
    size_t respSize = strlen(jsonString);
    const char  * buf = jsonString;

    write(fd, buf, respSize);
}

void handle_not_found(int fd) {
    const char  * response = "HTTP/1.1 404 Not Found\r\n\r\n";
    write(fd, response, strlen(response));
}