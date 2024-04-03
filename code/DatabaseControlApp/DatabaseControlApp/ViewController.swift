import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var selectTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectTableButton()
        makeRequest()
    
    }
    
    //MARK: actions
    @IBAction func GoExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //MARK: functions
    func makeRequest() {
        let networkManager = NetworkManager()

        // Пример параметров для POST запроса
        let parameters: [String: Any] = [
            "query": "SELECT table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');"
        ]

        networkManager.sendPostRequest(urlString: "http://82.179.140.18:44667/get_data", parameters: parameters) { (data, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                // Обработка полученных данных
                print("Response Data: \(data)")
                
                // Декодирование JSON-данных
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
            }
        }
    }

    
    func setSelectTableButton() {
        let optionClose = {(action: UIAction) in
            print(action.title)
        }
        
        if let selectTableButton = selectTableButton {
            selectTableButton.menu = UIMenu(children:[
                UIAction(title: "tab1", state: .on, handler: optionClose),
                UIAction(title: "tab2", handler: optionClose),
                UIAction(title: "tab3", handler: optionClose)
            ])
            selectTableButton.showsMenuAsPrimaryAction = true
            selectTableButton.changesSelectionAsPrimaryAction = true
        } else {
            print("selectTableButton is nil")
        }
    }
    
    
}


