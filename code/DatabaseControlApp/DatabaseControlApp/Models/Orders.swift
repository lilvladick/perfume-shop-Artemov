import UIKit

struct OrdersData: Codable {
    let order_id: String
    let customer_id: String
    let order_date: String
    let total_amount: String
    let updated_at: String
    let created_at: String
}

struct OrdersResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [OrdersData]
}
