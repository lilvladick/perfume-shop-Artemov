import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var selectTableButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var bottlesResponse: BottlesResponse?
    private var url = "http://82.179.140.18:44800/get_data"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BottleCell")
        //get selecttable button names and check server status
        //makeRequest()
        getdata()
    }
    
    //MARK: actions
    @IBAction func GoExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func selectTableButtonTapped(_ sender: Any) {
        getdata()
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
                print("Response Data: \(data)")
                
                // update UI in main flow
                DispatchQueue.main.async {
                                self.setSelectTableButton(jsonData: data)
                            }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            }
        }
    }

    func getdata() {
        let networkManager = NetworkManager()

        let parameters: [String: Any] = [
            "query": "SELECT * FROM bottles"
        ]

        networkManager.sendPostRequest(urlString: url, parameters: parameters) { [self] (data, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                print("Response Data: \(data)")
                
                // Parse data and update bottlesResponse
                do {
                    let decoder = JSONDecoder()
                    let bottlesResponse = try decoder.decode(BottlesResponse.self, from: data)
                    self.bottlesResponse = bottlesResponse
                    
                    // Update UI in main thread
                    DispatchQueue.main.async {
                        // Reload table data
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            }
        }
    }

    
    func setSelectTableButton(jsonData: Data) {
        do {
            // json parsing
            if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
               let rows = json["rows"] as? [[String: Any]] {
                
                var tableNames: [String] = []
                
                // getting tables names
                for row in rows {
                    if let tableName = row["table_name"] as? String {
                        tableNames.append(tableName)
                    }
                }
                
                if let selectTableButton = selectTableButton {
                    // actions for button
                    var actions: [UIAction] = []
                    
                    for tableName in tableNames {
                        let action = UIAction(title: tableName, handler: { _ in
                            print("Selected table: \(tableName)")
                            // call print table method
                            self.handleTableSelection(tableName: tableName)
                        })
                        actions.append(action)
                    }
                    
                    selectTableButton.menu = UIMenu(children: actions)
                    selectTableButton.showsMenuAsPrimaryAction = true
                    selectTableButton.changesSelectionAsPrimaryAction = true
                } else {
                    print("selectTableButton is nil")
                }
            } else {
                print("Failed to parse JSON")
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }

    func handleTableSelection(tableName: String) {
        // print table code
    }

    
    
}


