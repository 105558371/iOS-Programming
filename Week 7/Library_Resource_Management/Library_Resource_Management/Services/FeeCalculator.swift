import Foundation

class FeeCalculator {
    // Methods
    func calculateDeposit(book: PrintedBook) -> Double {
        return book.deposit
    }

    func calculateAccessFee(
        material: DigitalMaterial
    ) -> Double {
        return material.accessFee
    }

    func calculateLateFee(
        book: PrintedBook,
        daysLate: Int
    ) -> Double {
        var actualDaysLate = daysLate
        if actualDaysLate < 0 {
            actualDaysLate = 0
        }
        let fee = Double(actualDaysLate) * book.dailyLateFee
        return fee
    }

    func calculateTotalFee(
        deposit: Double,
        lateFee: Double,
        accessFee: Double
    ) -> Double {
        let total = deposit + lateFee + accessFee
        return total
    }
}
