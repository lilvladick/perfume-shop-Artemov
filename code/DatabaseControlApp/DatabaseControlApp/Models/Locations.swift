import UIKit

struct LocationsData: Codable {
    let location_id: String
    let location_name: String
    let updated_at: String
    let created_at: String
}

struct LocationsResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [LocationsData]
}
