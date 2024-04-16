import UIKit

struct IngredientData: Codable {
    let ingredient_id: String
    let ingredient_name: String
    let updated_at: String
    let created_at: String
}

struct IngredientResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [IngredientData]
}
