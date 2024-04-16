import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var selectTableButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var dataSource: (any DataSourceProtocol)?
    
    private var url = "http://82.179.140.18:44800/get_data"
    private var selectedTableName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SelectedTableView")
        makeRequest()
    }
    
    //MARK: actions
    @IBAction func GoExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: functions
    func makeRequest() {
        let networkManager = NetworkManager()

        let parameters: [String: Any] = [
            "query": "SELECT table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');"
        ]

        networkManager.sendPostRequest(urlString: url, parameters: parameters) { [self] (data, error) in
            if let error = error {
                print("Error: \(error)") // не ворк с инета кафедры
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.setSelectTableButton(jsonData: data)
                }
            }
        }
    }
    
    func setSelectTableButton(jsonData: Data) {
            do {
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let rows = json["rows"] as? [[String: Any]] {
                    
                    var tableNames: [String] = []

                    for row in rows {
                        if let tableName = row["table_name"] as? String {
                            tableNames.append(tableName)
                        }
                    }
                    
                    var actions: [UIAction] = []
                    
                    for tableName in tableNames {
                        let action = UIAction(title: tableName, handler: { [weak self] _ in
                            print("Selected table: \(tableName)")
                            self?.selectedTableName = tableName
                            self?.getData(tableName: tableName)
                        })
                        actions.append(action)
                    }
                    
                    selectTableButton.menu = UIMenu(children: actions)
                    selectTableButton.showsMenuAsPrimaryAction = true
                    selectTableButton.changesSelectionAsPrimaryAction = true
                } else {
                    print("Failed to parse JSON")
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }

    func getData(tableName: String) {
            let networkManager = NetworkManager()

            let parameters: [String: Any] = [
                "query": "SELECT * FROM \(tableName)"
            ]

            networkManager.sendPostRequest(urlString: url, parameters: parameters) { [weak self] (data, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                if let data = data {
                    
                    do {
                        if tableName == "bottles" {
                            let decoder = JSONDecoder()
                            let bottlesResponse = try decoder.decode(BottlesResponse.self, from: data)
                            self?.dataSource = bottlesResponse
                        } else if tableName == "locations" {
                            let decoder = JSONDecoder()
                            let locationsResponse = try decoder.decode(LocationsResponse.self, from: data)
                            self?.dataSource = locationsResponse
                        }
                        
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
        }
}
