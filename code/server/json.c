#include "json.h"

cJSON* queryResultToJSON(QueryResult* result) {
  if (result == NULL) {
    return NULL;
  }

  cJSON* root = cJSON_CreateObject();
  if (root == NULL) {
    goto cleanup;
  }

  // Добавляем количество строк (ntuples) и количество полей (nfields) в объект JSON
  cJSON_AddNumberToObjectUnsafe(root, "ntuples", result->ntuples);
  cJSON_AddNumberToObjectUnsafe(root, "nfields", result->nfields);

  // Создаем массив объектов, каждый из которых представляет собой строку результата
  cJSON* rows = cJSON_AddArrayToObject(root, "rows");
  if (rows == NULL) {
    goto cleanup;
  }

  // Проходим по каждой строке и добавляем ее в массив rows
  for (int i = 0; i < result->ntuples; ++i) {
    if (result->values[i] == NULL) {
      goto cleanup;
    }

    cJSON* row = cJSON_CreateObject();
    if (row == NULL) {
      goto cleanup;
    }

    // Проходим по каждому полю строки и добавляем его в массив row
    for (int j = 0; j < result->nfields; ++j) {
      if (result->column_names[j] == NULL) {
        goto cleanup;
      }

      cJSON* field = cJSON_CreateString(result->values[i][j]);
      if (field == NULL) {
        goto cleanup;
      }

      cJSON_AddItemToObject(row, result->column_names[j], field);
    }

    cJSON_AddItemToArray(rows, row);
  }

  return root;

cleanup:
  cJSON_Delete(root);
  return NULL;
}
