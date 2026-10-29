class DeliveryManager {
    private var orders: [DeliveryOrder] = []

    func add(_ order: DeliveryOrder) {
        if orders.contains(where: { $0.id == order.id }) {
            print("Order ID already exists!")
            return
        }

        orders.append(order)
        print("Order created successfully!")
    }

    func displayAll() {
        if orders.isEmpty {
            print("No orders available.")
            return
        }

        for order in orders {
            order.displayOrder()
            print("--------------------")
        }
    }

    func totalFees() -> Double {
        orders.reduce(0) {
            $0 + $1.calculateDeliveryFee()
        }
    }

    func summarizeFees() {
        for orderType in ["Standard", "Express", "Same-Day"] {
            let total = orders.filter {
                switch orderType {
                case "Standard": $0 is StandardDelivery
                case "Express": $0 is ExpressDelivery
                default: $0 is SameDayDelivery
                }
            }.reduce(0) {
                $0 + $1.calculateDeliveryFee()
            }

            print("\(orderType) Delivery Fees: \(total) VND")
        }

        print("Total Delivery Fees: \(totalFees()) VND")
    }

    func updateCustomer(id: String, name: String, address: String) {
        guard let order = orders.first(where: { $0.id == id }) else {
            print("Order not found.")
            return
        }

        order.updateCustomerInfo(name: name, address: address)
        print("Customer information updated.")
    }
}
