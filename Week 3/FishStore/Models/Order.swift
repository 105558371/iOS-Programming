import Foundation

struct Order: Identifiable {
    let id = UUID()
    var customerName: String
    var items: [CartItem]
    var orderDate: Date
    var status: OrderStatus
    var shippingFee: Double
}
