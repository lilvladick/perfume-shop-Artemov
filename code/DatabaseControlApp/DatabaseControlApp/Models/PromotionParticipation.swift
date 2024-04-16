import UIKit

struct PromotionParticipationData: Codable {
    let participation_id: String
    let perfume_id: String
    let promotion_id: String
    let updated_at: String
    let created_at: String
}

struct PromotionParticipationResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [PromotionParticipationData]
}
