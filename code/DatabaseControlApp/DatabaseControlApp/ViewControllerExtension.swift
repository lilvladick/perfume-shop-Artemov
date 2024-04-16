import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedTableView", for: indexPath)
        
        guard let item = dataSource?.rows[indexPath.row] as? Displayable else {
            return cell
        }
        
        var content = cell.defaultContentConfiguration()
        content.text = item.primaryText
        content.secondaryText = item.secondaryText
        
        cell.contentConfiguration = content
        return cell
    }
}
