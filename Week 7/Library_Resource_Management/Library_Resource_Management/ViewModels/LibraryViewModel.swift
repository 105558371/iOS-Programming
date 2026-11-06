import Foundation
import SwiftUI
import Combine

class LibraryViewModel: ObservableObject {
    // Properties
    @Published var resources: [LibraryResource]
    @Published var users: [LibraryUser]
    @Published var borrowingRecords: [BorrowingRecord]
    @Published var selectedUserId: String
    @Published var searchText: String
    @Published var message: String
    @Published var showAlert: Bool
    private var manager: LibraryManager

    // Constructor
    init() {
        manager = LibraryManager()
        resources = [LibraryResource]()
        users = [LibraryUser]()
        borrowingRecords = [BorrowingRecord]()
        selectedUserId = "U001"
        searchText = ""
        message = ""
        showAlert = false
        loadSampleData()
    }

    // Load sample data
    func loadSampleData() {
        // Create books
        let book1 = PrintedBook(
            id: "B001",
            title: "Swift Programming",
            publicationYear: 2024,
            author: "John Smith",
            isbn: "9781234567890",
            borrowingPeriod: 21,
            deposit: 10,
            dailyLateFee: 2
        )

        let book2 = PrintedBook(
            id: "B002",
            title: "Object Oriented Programming",
            publicationYear: 2023,
            author: "David Brown",
            isbn: "9789876543210",
            borrowingPeriod: 7,
            deposit: 5,
            dailyLateFee: 1
        )

        // Create journals
        let journal1 = AcademicJournal(
            id: "J001",
            title: "Computer Science Review",
            publicationYear: 2025,
            volume: 12,
            issue: 3,
            isBorrowable: false
        )

        let journal2 = AcademicJournal(
            id: "J002",
            title: "Software Engineering Journal",
            publicationYear: 2025,
            volume: 8,
            issue: 2,
            isBorrowable: true
        )

        // Create digital material
        let expirationDate = Calendar.current.date(
            byAdding: .year,
            value: 1,
            to: Date()
        ) ?? Date()

        let material1 = DigitalMaterial(
            id: "D001",
            title: "Online Swift Course",
            publicationYear: 2025,
            platform: "University LMS",
            expirationDate: expirationDate,
            maxSimultaneousUsers: 2,
            accessFee: 3
        )

        // Add resources
        do {
            try manager.addResource(resource: book1)
            try manager.addResource(resource: book2)
            try manager.addResource(resource: journal1)
            try manager.addResource(resource: journal2)
            try manager.addResource(resource: material1)

        }
        catch {
            message = error.localizedDescription
            showAlert = true
        }

        // Create users
        let user1 = LibraryUser(
            userId: "U001",
            name: "Alice"
        )

        let user2 = LibraryUser(
            userId: "U002",
            name: "John"
        )

        // Add users
        do {
            try manager.addUser(user: user1)
            try manager.addUser(user: user2)

        }
        catch {
            message = error.localizedDescription
            showAlert = true
        }
        refreshData()
    }

    // Refresh published data
    func refreshData() {
        resources = manager.allResources
        users = manager.allUsers
        borrowingRecords = manager.allBorrowingRecords
    }

    // Search resources
    var filteredResources: [LibraryResource] {
        if searchText.isEmpty {
            return resources
        }

        var results = [LibraryResource]()

        for resource in resources {
            if resource.title.localizedCaseInsensitiveContains(searchText) ||
                resource.id.localizedCaseInsensitiveContains(searchText) {
                results.append(resource)
            }
        }
        return results
    }

    // Check active borrowing
    func hasActiveBorrowing(resourceId: String) -> Bool {
        return manager.hasActiveBorrowing(
            resourceId: resourceId,
            userId: selectedUserId
        )
    }

    // Borrow resource
    func borrowResource(resourceId: String) {
        do {
            let fee = try manager.borrowResource(
                resourceId: resourceId,
                userId: selectedUserId
            )
            
            message = String(
                format: "Request successful! Applicable fee: $%.2f",
                fee
            )
        }
        catch {
            message = error.localizedDescription
        }
        refreshData()
        showAlert = true
    }

    // Return resource
    func returnResource(resourceId: String) {
        do {
            let lateFee = try manager.returnResource(
                resourceId: resourceId,
                userId: selectedUserId
            )

            message = String(
                format: "Return successful! Late fee: $%.2f",
                lateFee
            )
        }
        catch {
            message = error.localizedDescription
        }
        refreshData()
        showAlert = true
    }
}
