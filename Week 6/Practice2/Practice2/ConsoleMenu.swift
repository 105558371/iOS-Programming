//
//  ConsoleMenu.swift
//  Practice2
//
//  Created by SESEIU24007 on 29/10/26.
//


import Foundation

class ConsoleMenu {
    private let manager = DeliveryManager()

    func run() {
        while true {
            print("""

            ===== DELIVERY MANAGEMENT =====
            1. Create Standard Delivery
            2. Create Express Delivery
            3. Create Same-Day Delivery
            4. Display All Orders
            5. Update Customer Information
            6. Calculate Total Delivery Fees
            7. Delivery Fee Summary
            8. Exit
            ===============================
            Choice:
            """)

            switch readLine() {
            case "1": createOrder(type: 1)
            case "2": createOrder(type: 2)
            case "3": createOrder(type: 3)
            case "4": manager.displayAll()
            case "5": updateCustomer()
            case "6": print("Total: \(manager.totalFees()) VND")
            case "7": manager.summarizeFees()
            case "8":
                print("Goodbye!")
                return
            default:
                print("Invalid choice.")
            }
        }
    }

    private func ask(_ prompt: String) -> String {
        print(prompt)
        return readLine() ?? ""
    }

    private func createOrder(type: Int) {
        let id = ask("Order ID:")
        let name = ask("Customer name:")
        let address = ask("Delivery address:")

        guard let value = Double(ask("Order value (VND):")),
              value.isFinite, value >= 0 else {
            print("Invalid order value.")
            return
        }

        let order: DeliveryOrder

        switch type {
        case 1:
            order = StandardDelivery(
                orderID: id, customerName: name,
                deliveryAddress: address, orderValue: value
            )
        case 2:
            order = ExpressDelivery(
                orderID: id, customerName: name,
                deliveryAddress: address, orderValue: value
            )
        default:
            order = SameDayDelivery(
                orderID: id, customerName: name,
                deliveryAddress: address, orderValue: value
            )
        }

        manager.add(order)
    }

    private func updateCustomer() {
        let id = ask("Order ID:")
        let name = ask("New customer name:")
        let address = ask("New delivery address:")

        manager.updateCustomer(id: id, name: name, address: address)
    }
}