import UIKit

// Структура для представления каждой строки в JSON
struct BottleData: Codable {
    let bottle_id: String
    let bottle_name: String
    let volume: String
    let material: String
    let updated_at: String
    let created_at: String
}

// Структура для всего JSON
struct BottlesResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [BottleData]
}

// Расширение ViewController для протокола UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottlesResponse?.rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        
        // Создание конфигурации содержимого ячейки
        var content = cell.defaultContentConfiguration()
        
        guard let bottle = bottlesResponse?.rows[indexPath.row] else {
            return cell
        }
        
        // Настройка конфигурации содержимого
        content.text = bottle.bottle_name
        content.secondaryText = "Volume: \(bottle.volume), Material: \(bottle.material)"
        
        // Применение конфигурации к ячейке
        cell.contentConfiguration = content
        
        return cell
    }
}
