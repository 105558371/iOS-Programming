import Foundation

class ElectricityBill: Bill {
    private var electricityConsumption: Double
    
    var consumption: Double {
        get { electricityConsumption }
        set { if newValue >= 0 { electricityConsumption = newValue } }
    }
    
    init(
        billID: String,
        customerName: String,
        customerAddress: String,
        billingMonth: Int,
        billingYear: Int,
        consumption: Double
    ) {
        self.electricityConsumption = max(0, consumption)
        super.init(
            billID: billID,
            customerName: customerName,
            customerAddress: customerAddress,
            billingMonth: billingMonth,
            billingYear: billingYear
        )
    }
    
    override func calculateTotalCharge() -> Double {
        let ratePerKWh: Double = 2500.0
        return electricityConsumption * ratePerKWh
    }
}
