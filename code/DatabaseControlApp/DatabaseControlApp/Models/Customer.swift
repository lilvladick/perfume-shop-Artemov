import UIKit

struct CustomerData: Codable {
    let customer_id: String
    let customer_name: String
    let email: String
    let phone: String
    let updated_at: String
    let created_at: String
}

struct CustomerResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [CustomerData]
}
