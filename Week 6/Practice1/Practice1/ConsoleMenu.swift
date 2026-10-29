
import Foundation

class ConsoleMenu {
    private let manager = BillManager()

    func run() {
        while true {
            print("""
            
            ===== UTILITY BILL MANAGEMENT =====
            1. Create Electricity Bill
            2. Create Water Bill
            3. Create Internet Bill
            4. Display All Bills
            5. Update Customer Information
            6. Update Consumption
            7. Calculate Total
            8. Exit
            ===================================
            Choice:
            """)

            switch readLine() {
            case "1": createBill(type: 1)
            case "2": createBill(type: 2)
            case "3": createBill(type: 3)
            case "4": manager.displayAll()
            case "5": updateCustomer()
            case "6": updateConsumption()
            case "7": print("Total: \(manager.total()) VND")
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

    private func createBill(type: Int) {
        let id = ask("Bill ID:")
        let name = ask("Customer name:")
        let address = ask("Address:")

        guard let month = Int(ask("Billing month (1-12):")),
              (1...12).contains(month),
              let year = Int(ask("Billing year:")),
              year > 0 else {
            print("Invalid billing period.")
            return
        }

        switch type {
        case 1:
            guard let usage = Double(ask("Consumption (kWh):")),
                  usage.isFinite, usage >= 0 else {
                print("Invalid consumption.")
                return
            }

            manager.add(ElectricityBill(
                billID: id,
                customerName: name,
                customerAddress: address,
                billingMonth: month,
                billingYear: year,
                consumption: usage
            ))

        case 2:
            guard let usage = Double(ask("Consumption (m3):")),
                  usage.isFinite, usage >= 0 else {
                print("Invalid consumption.")
                return
            }

            manager.add(WaterBill(
                billID: id,
                customerName: name,
                customerAddress: address,
                billingMonth: month,
                billingYear: year,
                consumption: usage
            ))

        case 3:
            manager.add(InternetBill(
                billID: id,
                customerName: name,
                customerAddress: address,
                billingMonth: month,
                billingYear: year
            ))

        default:
            break
        }
    }

    private func updateCustomer() {
        let id = ask("Bill ID:")
        let name = ask("New customer name:")
        let address = ask("New address:")

        manager.updateCustomer(
            id: id,
            name: name,
            address: address
        )
    }

    private func updateConsumption() {
        let id = ask("Bill ID:")

        guard let value = Double(ask("New consumption:")),
              value.isFinite, value >= 0 else {
            print("Invalid consumption.")
            return
        }

        manager.updateConsumption(id: id, value: value)
    }
}
