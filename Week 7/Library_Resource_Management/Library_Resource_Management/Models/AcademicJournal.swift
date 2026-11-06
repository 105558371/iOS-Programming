import Foundation

class AcademicJournal: LibraryResource {
    // Attributes
    let volume: Int
    let issue: Int
    let isBorrowable: Bool

    // Constructor
    init(
        id: String,
        title: String,
        publicationYear: Int,
        volume: Int,
        issue: Int,
        isBorrowable: Bool
    ) {
        self.volume = volume
        self.issue = issue
        self.isBorrowable = isBorrowable
        super.init(
            id: id,
            title: title,
            publicationYear: publicationYear
        )
    }

    // Methods
    override func requestAccess() throws -> Double {
        if !isBorrowable {
            throw LibraryError.resourceNotBorrowable
        }
        return try super.requestAccess()
    }

    override func displayInformation() {
        super.displayInformation()
        print("Volume: \(volume)")
        print("Issue: \(issue)")
        print("Borrowable: \(isBorrowable)")
    }
}
