import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedTableView", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        guard let item = dataSource?.rows[indexPath.row] else {
            return cell
        }
        
        if let bottle = item as? BottleData {
            content.text = bottle.bottle_name
            content.secondaryText = "Volume: \(bottle.volume), Material: \(bottle.material)"
        } else if let location = item as? LocationsData {
            content.text = location.location_name
            content.secondaryText = "u win"
        }
        
        cell.contentConfiguration = content
        return cell
    }
}
