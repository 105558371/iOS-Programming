import Foundation

class LibraryUser: Identifiable {
    // Attributes
    let userId: String
    let name: String
    var id: String {return userId}
    private(set) var borrowingRecords: [BorrowingRecord]

    // Constructor
    init(
        userId: String,
        name: String
    ) {
        self.userId = userId
        self.name = name
        self.borrowingRecords = [BorrowingRecord]()
    }

    // Methods
    func addBorrowingRecord(record: BorrowingRecord) {
        borrowingRecords.append(record)
    }

    func displayInformation() {
        print("User ID: \(userId)")
        print("Name: \(name)")
        print("Borrowing Records: \(borrowingRecords.count)")
    }
}
