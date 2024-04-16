import Foundation

let responseTypes: [String: Codable.Type] = [
    "bottles": BottlesResponse.self,
    "locations": LocationsResponse.self,
    "composition": CompositionResponse.self,
    "ingredient": IngredientResponse.self,
    "customer": CustomerResponse.self,
    "orders": OrdersResponse.self,
    "payment": PaymentResponse.self,
    "delivery": DeliveryResponse.self,
    "review": ReviewResponse.self,
    "supplier": SupplierResponse.self,
    "supply": SupplyResponse.self,
    "promotionparticipation": PromotionParticipationResponse.self,
    "promotion": PromotionResponse.self,
    "shelf": ShelfResponse.self,
    "employee": EmployeeResponse.self,
    "salary": SalaryResponse.self,
    "brands": BrandsResponse.self,
    "perfume": PerfumeResponse.self,
    "categories": CategoriesResponse.self,
    "store": StoreResponse.self
]
