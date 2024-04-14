import UIKit

protocol DataSourceProtocol {
    var rows: [Any] { get }
}

extension LocationsResponse: DataSourceProtocol {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.rows.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        guard let item = dataSource?.rows[indexPath.row] else {
            return cell
        }
        
        // Предположим, что ваш объект данных имеет свойство bottle_name, volume и material
        if let bottle = item as? Bottle {
            content.text = bottle.bottle_name
            content.secondaryText = "Volume: \(bottle.volume), Material: \(bottle.material)"
        } else if let location = item as? Location {
            // Обработка для LocationsResponse, если необходимо
        } else if let supply = item as? Supply {
            // Обработка для SupplyResponse, если необходимо
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
}
