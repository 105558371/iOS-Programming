import Foundation

class DigitalMaterial: LibraryResource {
    // Attributes
    let platform: String
    let expirationDate: Date
    let maxSimultaneousUsers: Int
    let accessFee: Double
    private(set) var activeUsers: Int

    // Constructor
    init(
        id: String,
        title: String,
        publicationYear: Int,
        platform: String,
        expirationDate: Date,
        maxSimultaneousUsers: Int,
        accessFee: Double
    ) {
        self.platform = platform
        self.expirationDate = expirationDate
        self.maxSimultaneousUsers = maxSimultaneousUsers
        self.accessFee = accessFee
        self.activeUsers = 0
        super.init(
            id: id,
            title: title,
            publicationYear: publicationYear
        )
    }

    // Methods
    override var availabilityDescription: String {
        if Date() > expirationDate {
            return "License Expired"
        }
        return "Active Users: \(activeUsers)/\(maxSimultaneousUsers)"
    }

    override func requestAccess() throws -> Double {
        if Date() > expirationDate {
            throw LibraryError.licenseExpired
        }
        if activeUsers >= maxSimultaneousUsers {
            throw LibraryError.userLimitReached
        }
        activeUsers = activeUsers + 1
        return accessFee
    }

    override func returnResource() throws {
        if activeUsers <= 0 {
            throw LibraryError.resourceNotAvailable
        }
        activeUsers = activeUsers - 1
    }

    override func displayInformation() {
        super.displayInformation()
        print("Platform: \(platform)")
        print("Expiration Date: \(expirationDate)")
        print("Maximum Users: \(maxSimultaneousUsers)")
        print("Active Users: \(activeUsers)")
        print("Access Fee: $\(accessFee)")
    }
}
