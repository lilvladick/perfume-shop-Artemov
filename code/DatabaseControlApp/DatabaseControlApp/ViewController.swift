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
                        let decoder = JSONDecoder()
                        if tableName == "bottles" {
                            let bottlesResponse = try decoder.decode(BottlesResponse.self, from: data)
                            self?.dataSource = bottlesResponse
                        } else if tableName == "locations" {
                            let locationsResponse = try decoder.decode(LocationsResponse.self, from: data)
                            self?.dataSource = locationsResponse
                        } else if tableName == "composition" {
                            let compositionResponse = try decoder.decode(CompositionResponse.self, from: data)
                            self?.dataSource = compositionResponse
                        } else if tableName == "ingredient" {
                            let ingredientResponse = try decoder.decode(IngredientResponse.self, from: data)
                            self?.dataSource = ingredientResponse
                        } else if tableName == "customer" {
                            let customerResponse = try decoder.decode(CustomerResponse.self, from: data)
                            self?.dataSource = customerResponse
                        } else if tableName == "orders" {
                            let ordersResponse = try decoder.decode(OrdersResponse.self, from: data)
                            self?.dataSource = ordersResponse
                        } else if tableName == "payment" {
                            let paymentResponse = try decoder.decode(PaymentResponse.self, from: data)
                            self?.dataSource = paymentResponse
                        } else if tableName == "delivery" {
                            let deliveryResponse = try decoder.decode(DeliveryResponse.self, from: data)
                            self?.dataSource = deliveryResponse
                        } else if tableName == "review" {
                            let reviewResponse = try decoder.decode(ReviewResponse.self, from: data)
                            self?.dataSource = reviewResponse
                        } else if tableName == "supplier" {
                            let supplierResponse = try decoder.decode(SupplierResponse.self, from: data)
                            self?.dataSource = supplierResponse
                        } else if tableName == "supply" {
                            let supplyResponse = try decoder.decode(SupplyResponse.self, from: data)
                            self?.dataSource = supplyResponse
                        } else if tableName == "promotionparticipation" {
                            let promotionparticipationResponse = try decoder.decode(PromotionParticipationResponse.self, from: data)
                            self?.dataSource = promotionparticipationResponse
                        } else if tableName == "promotion" {
                            let promotionResponse = try decoder.decode(PromotionResponse.self, from: data)
                            self?.dataSource = promotionResponse
                        } else if tableName == "shelf" {
                            let shelfResponse = try decoder.decode(ShelfResponse.self, from: data)
                            self?.dataSource = shelfResponse
                        } else if tableName == "employee" {
                            let employeeResponse = try decoder.decode(EmployeeResponse.self, from: data)
                            self?.dataSource = employeeResponse
                        } else if tableName == "salary" {
                            let salaryResponse = try decoder.decode(SalaryResponse.self, from: data)
                            self?.dataSource = salaryResponse
                        } else if tableName == "brands" {
                            let brandsResponse = try decoder.decode(BrandsResponse.self, from: data)
                            self?.dataSource = brandsResponse
                        } else if tableName == "perfume" {
                            let perfumeResponse = try decoder.decode(PerfumeResponse.self, from: data)
                            self?.dataSource = perfumeResponse
                        } else if tableName == "categories" {
                            let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
                            self?.dataSource = categoriesResponse
                        } else if tableName == "store" {
                            let storeResponse = try decoder.decode(StoreResponse.self, from: data)
                            self?.dataSource = storeResponse
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
