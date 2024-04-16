import UIKit

struct BottleData: Codable {
    let bottle_id: String
    let bottle_name: String
    let volume: String
    let material: String
    let updated_at: String
    let created_at: String
}

struct BottlesResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [BottleData]
}

