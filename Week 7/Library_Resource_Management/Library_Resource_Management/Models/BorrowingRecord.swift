import Foundation

class BorrowingRecord: Identifiable {
    // Attributes
    let id: String
    let borrowerId: String
    let borrowerName: String
    let resourceId: String
    let resourceTitle: String
    let borrowingDate: Date
    let dueDate: Date
    private(set) var returnDate: Date?
    private(set) var status: BorrowingStatus
    let initialFee: Double

    // Constructor
    init(
        id: String,
        borrowerId: String,
        borrowerName: String,
        resourceId: String,
        resourceTitle: String,
        borrowingDate: Date,
        dueDate: Date,
        initialFee: Double
    ) {
        self.id = id
        self.borrowerId = borrowerId
        self.borrowerName = borrowerName
        self.resourceId = resourceId
        self.resourceTitle = resourceTitle
        self.borrowingDate = borrowingDate
        self.dueDate = dueDate
        self.returnDate = nil
        self.status = .borrowed
        self.initialFee = initialFee
    }

    // Methods
    func calculateOverdueDays(date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [.day],
            from: dueDate,
            to: date
        )
        var daysLate = components.day ?? 0
        if daysLate < 0 {
            daysLate = 0
        }
        return daysLate
    }

    func completeReturn() throws {
        if status == .returned {
            throw LibraryError.alreadyReturned
        }
        returnDate = Date()
        status = .returned
    }
}
