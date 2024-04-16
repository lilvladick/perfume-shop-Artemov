import UIKit

struct ReviewsData: Codable {
    let review_id: String
    let perfume_id: String
    let customer_id: String
    let rating: String
    let comment: String
    let updated_at: String
    let created_at: String
}

struct ReviewResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [ReviewsData]
}
