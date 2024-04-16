import UIKit

struct SalaryData: Codable {
    let salary_id: String
    let employee_id: String
    let month: String
    let amount: String
    let updated_at: String
    let created_at: String
}

struct SalaryResponse: Codable {
    let ntuples: Int
    let nfields: Int
    let rows: [SalaryData]
}
