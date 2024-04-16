import UIKit

struct PaymentData: Codable {
    let payment_id: String
    let order_id: String
    let payment_date: String
    let payment_method: String
    let updated_at: String
    let created_at: String
}

struct PaymentResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [PaymentData]
}
