import Foundation

class InternetBill: Bill {
    private let monthlySubscriptionFee: Double = 200000.0 // Fixed monthly fee
    
    override init(
        billID: String,
        customerName: String,
        customerAddress: String,
        billingMonth: Int,
        billingYear: Int
    ) {
        super.init(
            billID: billID,
            customerName: customerName,
            customerAddress: customerAddress,
            billingMonth: billingMonth,
            billingYear: billingYear
        )
    }
    
    override func calculateTotalCharge() -> Double {
        return monthlySubscriptionFee
    }
}
