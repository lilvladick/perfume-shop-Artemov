import UIKit

struct ShelfData: Codable {
    let shelf_id: String
    let store_id: String
    let shelf_number: String
    let updated_at: String
    let created_at: String
}

struct ShelfResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [ShelfData]
}
