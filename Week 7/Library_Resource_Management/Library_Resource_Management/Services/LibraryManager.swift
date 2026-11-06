import Foundation

class LibraryManager {
    // Attributes
    private var resources: [LibraryResource]
    private var users: [LibraryUser]
    private var borrowingRecords: [BorrowingRecord]
    private var feeCalculator: FeeCalculator

    // Read-only access for ViewModel
    var allResources: [LibraryResource] {
        return resources
    }

    var allUsers: [LibraryUser] {
        return users
    }

    var allBorrowingRecords: [BorrowingRecord] {
        return borrowingRecords
    }

    // Constructor
    init() {
        resources = [LibraryResource]()
        users = [LibraryUser]()
        borrowingRecords = [BorrowingRecord]()
        feeCalculator = FeeCalculator()
    }

    // Methods
    func addResource(resource: LibraryResource) throws {
        for existingResource in resources {
            if existingResource.id == resource.id {
                throw LibraryError.resourceAlreadyExists
            }
        }
        resources.append(resource)
    }

    func addUser(user: LibraryUser) throws {
        for existingUser in users {
            if existingUser.userId == user.userId {
                throw LibraryError.invalidResource
            }
        }
        users.append(user)
    }

    func searchResource(id: String) -> LibraryResource? {
        for resource in resources {
            if resource.id == id {
                return resource
            }
        }
        return nil
    }

    func searchUser(userId: String) -> LibraryUser? {
        for user in users {
            if user.userId == userId {
                return user
            }
        }
        return nil
    }

    func hasActiveBorrowing(
        resourceId: String,
        userId: String
    ) -> Bool {
        for record in borrowingRecords {
            if record.resourceId == resourceId &&
                record.borrowerId == userId &&
                record.status == .borrowed {
                return true
            }
        }
        return false
    }

    func borrowResource(
        resourceId: String,
        userId: String
    ) throws -> Double {
        // Find resource
        guard let resource = searchResource(id: resourceId) else {
            throw LibraryError.resourceNotFound
        }
        // Find user
        guard let user = searchUser(userId: userId) else {
            throw LibraryError.userNotFound
        }
        
        // Prevent duplicate access by the same user
        if hasActiveBorrowing(
            resourceId: resourceId,
            userId: userId
        ) {
            throw LibraryError.resourceNotAvailable
        }
        
        let initialFee = try resource.requestAccess()   // Request access
        let borrowingDate = Date()  // Set borrowing date
        var borrowingDays = 7   // Default borrowing period
        
        // Check resource type
        if let book = resource as? PrintedBook {
            borrowingDays = book.borrowingPeriod
        }
        if resource is DigitalMaterial {
            borrowingDays = 1
        }

        // Calculate due date
        guard let dueDate = Calendar.current.date(
            byAdding: .day,
            value: borrowingDays,
            to: borrowingDate
        ) else {
            try resource.returnResource()
            throw LibraryError.invalidResource
        }

        // Create borrowing record
        let record = BorrowingRecord(
            id: UUID().uuidString,
            borrowerId: user.userId,
            borrowerName: user.name,
            resourceId: resource.id,
            resourceTitle: resource.title,
            borrowingDate: borrowingDate,
            dueDate: dueDate,
            initialFee: initialFee
        )

        // Save record
        borrowingRecords.append(record)
        user.addBorrowingRecord(record: record)
        return initialFee
    }

    // Return resource
    func returnResource(
        resourceId: String,
        userId: String
    ) throws -> Double {
        // Find resource
        guard let resource = searchResource(id: resourceId) else {
            throw LibraryError.resourceNotFound
        }
        // Find user
        guard searchUser(userId: userId) != nil else {
            throw LibraryError.userNotFound
        }
        // Find active borrowing record
        var activeRecord: BorrowingRecord? = nil
        for record in borrowingRecords {
            if record.resourceId == resourceId &&
                record.borrowerId == userId &&
                record.status == .borrowed {
                activeRecord = record
                break
            }
        }
        guard let record = activeRecord else {
            throw LibraryError.noActiveBorrowing
        }
        // Calculate late fee
        var lateFee: Double = 0
        if let book = resource as? PrintedBook {
            let daysLate = record.calculateOverdueDays(
                date: Date()
            )
            lateFee = feeCalculator.calculateLateFee(
                book: book,
                daysLate: daysLate
            )
        }

        // Return resource
        try resource.returnResource()
        // Complete borrowing record
        try record.completeReturn()
        return lateFee
    }
}
