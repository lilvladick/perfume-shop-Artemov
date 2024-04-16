import UIKit

struct StoreData: Codable {
    let store_id: String
    let perfume_id: String
    let store_name: String
    let location_id: String
    let updated_at: String
    let created_at: String
}

struct StoreResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [StoreData]
}
