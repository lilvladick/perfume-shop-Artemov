import UIKit

struct CategoriesData: Codable {
    let category_id: String
    let Category_name: String
    let updated_at: String
    let created_at: String
}

struct CategoriesResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [CategoriesData]
}
