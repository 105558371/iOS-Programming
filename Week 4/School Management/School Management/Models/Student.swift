import Foundation

struct Student: Identifiable, Codable, Hashable {
    let id: String // Student ID (e.g., SESEIU24007)
    var name: String
    var className: String
    var dateOfBirth: String
}
