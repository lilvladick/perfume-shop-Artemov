import UIKit

struct DeliveryData: Codable {
    let delivery_id: String
    let order_id: String
    let delivery_date: String
    let address: String
    let updated_at: String
    let created_at: String
}

struct DeliveryResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [DeliveryData]
}
