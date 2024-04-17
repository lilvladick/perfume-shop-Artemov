#include "http.h"

void handle_post(int fd, char *  body) {
    cJSON *  parsedBody = cJSON_Parse(body);
    if (!parsedBody) {
        handle_not_found(fd);
        return;
    }

    cJSON *  query = cJSON_GetObjectItemCaseSensitive(parsedBody, "query");
    if (!query || !query->valuestring) {
        handle_not_found(fd);
        cJSON_Delete(parsedBody);
        return;
    }

    QueryResult  * result = makeQuery(query->valuestring);
    cJSON  * jsonResponse = queryResultToJSON(result);

    const char  * headers = "HTTP/1.1 200 OK\r\n"
                          "Content-Type: application/json\r\n\r\n";
    write(fd, headers, strlen(headers));

    char  * jsonString = cJSON_Print(jsonResponse);
    size_t respSize = strlen(jsonString);
    const char  * buf = jsonString;

    write(fd, buf, respSize);

    cJSON_Delete(parsedBody);
    cJSON_Delete(jsonResponse); 
}

void handle_not_found(int fd) {
    const char  * response = "HTTP/1.1 404 Not Found\r\n\r\n";
    write(fd, response, strlen(response));
}