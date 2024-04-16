import UIKit

struct PromotionData: Codable {
    let promotion_id: String
    let promotion_name: String
    let start_date: String
    let end_date: String
    let updated_at: String
    let created_at: String
}

struct PromotionResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [PromotionData]
}
