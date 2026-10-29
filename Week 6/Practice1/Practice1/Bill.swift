import Foundation

class Bill {
    private let billID: String
    private var customerName: String
    private var customerAddress: String
    private let billingMonth: Int
    private let billingYear: Int
    
    var id: String {
        return billID
    }
    
    var name: String {
        get { customerName }
        set { customerName = newValue }
    }
    
    var address: String {
        get { customerAddress }
        set { customerAddress = newValue }
    }
    
    var month: Int {
        return billingMonth
    }
    
    var year: Int {
        return billingYear
    }

    init(
        billID: String,
        customerName: String,
        customerAddress: String,
        billingMonth: Int,
        billingYear: Int
    ) {
        self.billID = billID
        self.customerName = customerName
        self.customerAddress = customerAddress
        self.billingMonth = billingMonth
        self.billingYear = billingYear
    }
    
    func updateCustomerInfo(
        name: String,
        address: String
    ) {
        customerName = name
        customerAddress = address
    }

    // Must be overridden by subclasses
    func calculateTotalCharge() -> Double {
        fatalError("Subclasses must implement calculateCharge()")
    }

    func displayBill() {
        print("Bill ID: \(billID)")
        print("Customer: \(customerName)")
        print("Address: \(customerAddress)")
        print("Billing period: \(billingMonth)/\(billingYear)")
        print("Total: \(calculateTotalCharge()) VND")
    }
}
