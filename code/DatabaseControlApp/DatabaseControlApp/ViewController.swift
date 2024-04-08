import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var selectTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get selecttable button names and check server status
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

        networkManager.sendPostRequest(urlString: "http://82.179.140.18:44668/get_data", parameters: parameters) { [self] (data, error) in
            if let error = error {
                print("Error: \(error)")
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


