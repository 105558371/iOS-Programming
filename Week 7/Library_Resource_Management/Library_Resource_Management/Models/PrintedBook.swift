import Foundation

class PrintedBook: LibraryResource {
    // Attributes
    let author: String
    let isbn: String
    let borrowingPeriod: Int
    let deposit: Double
    let dailyLateFee: Double

    // Constructor
    init(
        id: String,
        title: String,
        publicationYear: Int,
        author: String,
        isbn: String,
        borrowingPeriod: Int,
        deposit: Double,
        dailyLateFee: Double
    ) {
        self.author = author
        self.isbn = isbn
        self.borrowingPeriod = borrowingPeriod
        self.deposit = deposit
        self.dailyLateFee = dailyLateFee
        super.init(
            id: id,
            title: title,
            publicationYear: publicationYear
        )
    }

    // Methods
    override func requestAccess() throws -> Double {
        try super.requestAccess()
        return deposit
    }

    func calculateLateFee(daysLate: Int) -> Double {
        var actualDaysLate = daysLate
        if actualDaysLate < 0 {
            actualDaysLate = 0
        }
        let fee = Double(actualDaysLate) * dailyLateFee
        return fee
    }

    override func displayInformation() {
        super.displayInformation()
        print("Author: \(author)")
        print("ISBN: \(isbn)")
        print("Borrowing Period: \(borrowingPeriod)")
        print("Deposit: $\(deposit)")
        print("Daily Late Fee: $\(dailyLateFee)")
    }
}
