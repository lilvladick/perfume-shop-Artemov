import UIKit

struct SupplyData: Codable {
    let supply_id: String
    let supplier_name: String
    let perfume_id: String
    let quantity: String
    let supply_date: String
    let updated_at: String
    let created_at: String
}

struct SupplyResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [SupplyData]
}
