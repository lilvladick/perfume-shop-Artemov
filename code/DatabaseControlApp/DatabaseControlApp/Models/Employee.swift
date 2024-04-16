import UIKit

struct EmployeeData: Codable {
    let employee_id: String
    let employee_name: String
    let store_id: String
    let position: String
    let updated_at: String
    let created_at: String
}

struct EmployeeResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [EmployeeData]
}
