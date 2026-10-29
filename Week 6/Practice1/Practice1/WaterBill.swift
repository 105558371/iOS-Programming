import Foundation

class WaterBill: Bill {
    private var waterConsumption: Double
    
    var consumption: Double {
        get { waterConsumption }
        set { if newValue >= 0 { waterConsumption = newValue } }
    }
    
    init(
        billID: String,
        customerName: String,
        customerAddress: String,
        billingMonth: Int,
        billingYear: Int,
        consumption: Double
    ) {
        self.waterConsumption = max(0, consumption)
        super.init(
            billID: billID,
            customerName: customerName,
            customerAddress: customerAddress,
            billingMonth: billingMonth,
            billingYear: billingYear
        )
    }
    
    override func calculateTotalCharge() -> Double {
        let ratePerCubicMeter: Double = 10000.0
        return waterConsumption * ratePerCubicMeter
    }
}
