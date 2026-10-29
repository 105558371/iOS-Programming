import Foundation

class BillManager {
    private var bills: [Bill] = []

    func add(_ bill: Bill) {
        if bills.contains(where: { $0.id == bill.id }) {
            print("Bill ID already exists!")
            return
        }
        bills.append(bill)
        print("Bill created successfully!")
    }

    func displayAll() {
        if bills.isEmpty {
            print("No bills available.")
            return
        }

        for bill in bills {
            bill.displayBill()
            print("--------------------")
        }
    }

    func total() -> Double {
        bills.reduce(0) { $0 + $1.calculateTotalCharge() }
    }

    func updateCustomer(id: String, name: String, address: String) {
        guard let bill = bills.first(where: { $0.id == id }) else {
            print("Bill not found.")
            return
        }

        bill.updateCustomerInfo(name: name, address: address)
        print("Customer information updated.")
    }

    func updateConsumption(id: String, value: Double) {
        guard value >= 0,
              let bill = bills.first(where: { $0.id == id }) else {
            print("Invalid consumption or bill ID.")
            return
        }

        if let electricity = bill as? ElectricityBill {
            electricity.consumption = value
        } else if let water = bill as? WaterBill {
            water.consumption = value
        } else {
            print("Internet bills have no consumption value.")
            return
        }

        print("Consumption updated.")
    }
}
