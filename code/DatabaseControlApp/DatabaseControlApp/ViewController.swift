import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var selectTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectTableButton()
        //makeRequest()
    
    }
    
    //MARK: actions
    @IBAction func GoExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //MARK: functions
//    func makeRequest() {
//        let parameters = "{\n    \"query\": \"SELECT table_name FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');\"\n}"
//        guard let postData = parameters.data(using: .utf8) else { return }
//        let networkManager = NetworkManager()
//        
//        networkManager.getData(postData: postData)
//        
//    }
    
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


