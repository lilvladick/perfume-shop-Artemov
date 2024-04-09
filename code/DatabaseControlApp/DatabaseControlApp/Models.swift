import Foundation

struct Location {
    let locationID: Int
    let locationName: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Customer {
    let customerID: Int
    let customerName: String
    let email: String
    let phone: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Brand {
    let brandID: Int
    let brandName: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Category {
    let categoryID: Int
    let categoryName: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Bottle {
    let bottleID: Int
    let bottleName: String
    let volume: Int
    let material: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Ingredient {
    let ingredientID: Int
    let ingredientName: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Perfume {
    let perfumeID: Int
    let perfumeName: String
    let brandID: Int
    let categoryID: Int
    let bottleID: Int
    let price: Decimal
    let descriptions: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Store {
    let storeID: Int
    let perfumeID: Int
    let storeName: String
    let locationID: Int
    let updatedAt: Date?
    let createdAt: Date
}

struct Composition {
    let compositionID: Int
    let perfumeID: Int
    let ingredientID: Int
    let percent: Int
    let updatedAt: Date?
    let createdAt: Date
}

struct Order {
    let orderID: Int
    let customerID: Int
    let orderDate: Date?
    let totalAmount: Decimal
    let updatedAt: Date?
    let createdAt: Date
}

struct Payment {
    let paymentID: Int
    let orderID: Int
    let paymentDate: Date?
    let paymentMethod: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Delivery {
    let deliveryID: Int
    let orderID: Int
    let deliveryDate: Date?
    let address: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Review {
    let reviewID: Int
    let perfumeID: Int
    let customerID: Int
    let rating: Int
    let comment: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Supplier {
    let supplierID: Int
    let supplierName: String
    let contactPerson: String
    let phone: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Supply {
    let supplyID: Int
    let supplierID: Int
    let perfumeID: Int
    let quantity: Int
    let supplyDate: Date?
    let updatedAt: Date?
    let createdAt: Date
}

struct Promotion {
    let promotionID: Int
    let promotionName: String
    let startDate: Date?
    let endDate: Date?
    let updatedAt: Date?
    let createdAt: Date
}

struct PromotionParticipation {
    let participationID: Int
    let perfumeID: Int
    let promotionID: Int
    let updatedAt: Date?
    let createdAt: Date
}

struct Shelf {
    let shelfID: Int
    let storeID: Int
    let shelfNumber: Int
    let updatedAt: Date?
    let createdAt: Date
}

struct Employee {
    let employeeID: Int
    let employeeName: String
    let storeID: Int
    let position: String
    let updatedAt: Date?
    let createdAt: Date
}

struct Salary {
    let salaryID: Int
    let employeeID: Int
    let month: Date
    let amount: Decimal
    let updatedAt: Date?
    let createdAt: Date
}
