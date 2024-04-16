import UIKit

struct CompositionData: Codable {
    let composition_id: String
    let perfume_id: String
    let ingegient_id: String
    let percent: String
    let updated_at: String
    let created_at: String
}

struct CompositionResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [CompositionData]
}
