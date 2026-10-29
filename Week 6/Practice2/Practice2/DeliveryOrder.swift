//
//  DeliveryOrder.swift
//  Practice2
//
//  Created by SESEIU24007 on 29/10/26.
//


class DeliveryOrder {
    private let orderID: String
    private var customerName: String
    private var deliveryAddress: String
    private let orderValue: Double

    var id: String { orderID }
    var name: String { customerName }
    var address: String { deliveryAddress }
    var value: Double { orderValue }

    init(
        orderID: String,
        customerName: String,
        deliveryAddress: String,
        orderValue: Double
    ) {
        self.orderID = orderID
        self.customerName = customerName
        self.deliveryAddress = deliveryAddress
        self.orderValue = orderValue
    }

    func updateCustomerInfo(name: String, address: String) {
        customerName = name
        deliveryAddress = address
    }

    func calculateDeliveryFee() -> Double {
        fatalError("Subclass must implement this method")
    }

    func displayOrder() {
        print("Order ID: \(id)")
        print("Customer: \(name)")
        print("Address: \(address)")
        print("Order Value: \(value) VND")
        print("Delivery Fee: \(calculateDeliveryFee()) VND")
    }
}

class StandardDelivery: DeliveryOrder {
    override func calculateDeliveryFee() -> Double {
        return 20000
    }
}

class ExpressDelivery: DeliveryOrder {
    override func calculateDeliveryFee() -> Double {
        return 40000
    }
}

class SameDayDelivery: DeliveryOrder {
    override func calculateDeliveryFee() -> Double {
        return 60000
    }
}
