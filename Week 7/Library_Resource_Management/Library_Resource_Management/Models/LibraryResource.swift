import Foundation

class LibraryResource: Identifiable {
    // Attributes
    let id: String
    let title: String
    let publicationYear: Int
    private(set) var status: ResourceStatus

    // Properties
    var isAvailable: Bool {
        return status == .available
    }

    var availabilityDescription: String {
        return status.rawValue
    }

    // Constructor
    init(
        id: String,
        title: String,
        publicationYear: Int
    ) {

        self.id = id
        self.title = title
        self.publicationYear = publicationYear
        self.status = .available
    }

    // Methods
    func requestAccess() throws -> Double {
        if status != .available {
            throw LibraryError.resourceNotAvailable
        }
        status = .borrowed
        return 0
    }
    
    func returnResource() throws {
        if status != .borrowed {
            throw LibraryError.resourceNotAvailable
        }
        status = .available
    }

    func displayInformation() {
        print("ID: \(id)")
        print("Title: \(title)")
        print("Publication Year: \(publicationYear)")
        print("Status: \(status.rawValue)")
    }
}
