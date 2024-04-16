import UIKit

struct SupplierData: Codable {
    let supplier_id: String
    let supplier_name: String
    let contact_person: String
    let phone: String
    let updated_at: String
    let created_at: String
}

struct SupplierResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [SupplierData]
}
