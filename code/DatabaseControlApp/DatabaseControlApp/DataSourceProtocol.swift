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
