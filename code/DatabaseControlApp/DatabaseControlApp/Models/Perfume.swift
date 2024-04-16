import UIKit

struct PerfumeData: Codable {
    let perfume_id: String
    let perfume_name: String
    let brand_id: String
    let category_id: String
    let bottle_id: String
    let price: String
    let descriptions: String
    let updated_at: String
    let created_at: String
}

struct PerfumeResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [PerfumeData]
}
