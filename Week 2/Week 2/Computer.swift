import Foundation

struct Computer: Identifiable {
    let id = UUID()         // Unique identifier
    var name: String        // Computer name (e.g., "PC06")
    var location: String    // Location (e.g., "Lab A")
    var isAvailable: Bool   // Status in lab
}
