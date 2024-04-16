import UIKit

struct BrandsData: Codable {
    let brand_id: String
    let brand_name: String
    let updated_at: String
    let created_at: String
}

struct BrandsResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [BrandsData]
}
