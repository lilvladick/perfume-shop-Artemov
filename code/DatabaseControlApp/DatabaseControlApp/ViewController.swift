//
//  ViewController.swift
//  DatabaseControlApp
//
//  Created by Владислав Кириллов on 02.04.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var selectTableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelectTableButton()
        // Do any additional setup after loading the view.
    }
    
    //MARK: actions
    @IBAction func GoExit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    //MARK: functions
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


