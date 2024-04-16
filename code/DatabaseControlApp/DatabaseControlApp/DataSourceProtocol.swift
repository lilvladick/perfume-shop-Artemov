import Foundation

protocol DataSourceProtocol {
    associatedtype ItemType
    var rows: [ItemType] { get }
}

extension LocationsResponse: DataSourceProtocol {
    typealias ItemType = LocationsData
}

extension BottlesResponse: DataSourceProtocol {
    typealias ItemType = BottleData
}

extension CustomerResponse: DataSourceProtocol {
    typealias ItemType = CustomerData
}

extension BrandsResponse: DataSourceProtocol {
    typealias ItemType = BrandsData
}

extension CategoriesResponse: DataSourceProtocol {
    typealias ItemType = CategoriesData
}

extension IngredientResponse: DataSourceProtocol {
    typealias ItemType = IngredientData
}

extension PerfumeResponse: DataSourceProtocol {
    typealias ItemType = PerfumeData
}

extension StoreResponse: DataSourceProtocol {
    typealias ItemType = StoreData
}

extension CompositionResponse: DataSourceProtocol {
    typealias ItemType = CompositionData
}

extension OrdersResponse: DataSourceProtocol {
    typealias ItemType = OrdersData
}

extension PaymentResponse: DataSourceProtocol {
    typealias ItemType = PaymentData
}

extension DeliveryResponse: DataSourceProtocol {
    typealias ItemType = DeliveryData
}

extension ReviewResponse: DataSourceProtocol {
    typealias ItemType = ReviewsData
}

extension SupplierResponse: DataSourceProtocol {
    typealias ItemType = SupplierData
}

extension SupplyResponse: DataSourceProtocol {
    typealias ItemType = SupplyData
}

extension PromotionResponse: DataSourceProtocol {
    typealias ItemType = PromotionData
}

extension PromotionParticipationResponse: DataSourceProtocol {
    typealias ItemType = PromotionParticipationData
}

extension ShelfResponse: DataSourceProtocol {
    typealias ItemType = ShelfData
}

extension EmployeeResponse: DataSourceProtocol {
    typealias ItemType = EmployeeData
}

extension SalaryResponse: DataSourceProtocol {
    typealias ItemType = SalaryData
}
