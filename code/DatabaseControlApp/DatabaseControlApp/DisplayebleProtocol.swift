protocol Displayable {
    var primaryText: String { get }
    var secondaryText: String { get }
}

extension BottleData: Displayable {
    var primaryText: String { return bottle_name }
    var secondaryText: String { return "Volume: \(volume), Material: \(material)" }
}

extension LocationsData: Displayable {
    var primaryText: String { return location_name }
    var secondaryText: String { return "" }
}

extension CustomerData: Displayable {
    var primaryText: String { return customer_name }
    var secondaryText: String { return "Email: \(email), Phone: \(phone)" }
}

extension BrandsData: Displayable {
    var primaryText: String { return brand_name }
    var secondaryText: String { return "" }
}

extension CategoriesData: Displayable {
    var primaryText: String { return Category_name }
    var secondaryText: String { return "" }
}

extension IngredientData: Displayable {
    var primaryText: String { return ingredient_name }
    var secondaryText: String { return "" }
}

extension PerfumeData: Displayable {
    var primaryText: String { return perfume_name }
    var secondaryText: String { return "Brand_id: \(brand_id), Category_id: \(category_id), Bottle_id: \(bottle_id), Price: \(price), Description: \(descriptions)" }
}

extension StoreData: Displayable {
    var primaryText: String { return store_name }
    var secondaryText: String { return "Perfume_id: \(perfume_id), Location_id: \(location_id)" }
}

extension CompositionData: Displayable {
    var primaryText: String { return percent }
    var secondaryText: String { return "Perfume_id: \(perfume_id), Ingredient_id: \(ingredient_id), percent: \(percent)" }
}

extension OrdersData: Displayable {
    var primaryText: String { return order_date }
    var secondaryText: String { return "Customer_id: \(customer_id), Order_date: \(order_date), total_amount: \(total_amount)" }
}

extension PaymentData: Displayable {
    var primaryText: String { return payment_date }
    var secondaryText: String { return "Payment_date: \(payment_date), Order_id: \(order_id), Payment_method: \(payment_method)" }
}

extension DeliveryData: Displayable {
    var primaryText: String { return delivery_date }
    var secondaryText: String { return "Order_id: \(order_id), Delivery_date: \(delivery_date), address: \(address)" }
}

extension ReviewsData: Displayable {
    var primaryText: String { return rating }
    var secondaryText: String { return "Perfume_id: \(perfume_id), Customer_id: \(customer_id), Comment: \(comment)" }
}

extension SupplierData: Displayable {
    var primaryText: String { return supplier_name }
    var secondaryText: String { return "Contact_person: \(contact_person), Phone: \(phone)" }
}

extension SupplyData: Displayable {
    var primaryText: String { return supply_date }
    var secondaryText: String { return "Perfume_id: \(perfume_id), Quantity: \(quantity), Supply_date: \(supply_date)" }
}

extension PromotionData: Displayable {
    var primaryText: String { return promotion_name }
    var secondaryText: String { return "Start_date: \(start_date), End_date: \(end_date)" }
}

extension PromotionParticipationData: Displayable {
    var primaryText: String { return participation_id }
    var secondaryText: String { return "Promotion_id: \(promotion_id), Perfume_id: \(perfume_id)" }
}

extension ShelfData: Displayable {
    var primaryText: String { return shelf_number }
    var secondaryText: String { return "Store_id: \(store_id)" }
}

extension EmployeeData: Displayable {
    var primaryText: String { return employee_name }
    var secondaryText: String { return "Store_id: \(store_id), Position: \(position)" }
}

extension SalaryData: Displayable {
    var primaryText: String { return amount }
    var secondaryText: String { return "Employee_id: \(employee_id), Month: \(month)" }
}
