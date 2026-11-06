import Foundation

enum ResourceStatus: String {
    case available = "Available"
    case borrowed = "Borrowed"
    case unavailable = "Unavailable"
}

enum BorrowingStatus: String {
    case borrowed = "Borrowed"
    case returned = "Returned"
    case overdue = "Overdue"
}

enum LibraryError: Error, LocalizedError {
    case resourceNotFound
    case userNotFound
    case resourceNotAvailable
    case resourceNotBorrowable
    case resourceAlreadyExists
    case noActiveBorrowing
    case alreadyReturned
    case licenseExpired
    case userLimitReached
    case invalidResource

    var errorDescription: String? {
        switch self {
        case .resourceNotFound:
            return "Resource not found."
        case .userNotFound:
            return "User not found."
        case .resourceNotAvailable:
            return "This resource is currently unavailable."
        case .resourceNotBorrowable:
            return "This journal can only be accessed inside the library."
        case .resourceAlreadyExists:
            return "A resource with this ID already exists."
        case .noActiveBorrowing:
            return "No active borrowing record was found."
        case .alreadyReturned:
            return "This resource has already been returned."
        case .licenseExpired:
            return "The digital license has expired."
        case .userLimitReached:
            return "Maximum simultaneous users reached."
        case .invalidResource:
            return "Invalid resource information."
        }
    }
}
