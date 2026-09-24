import Foundation

struct Student: Identifiable {
    let id: String     
    var name: String
    var gpa: Double
}

// Initialize Array with Initial Data
var students: [Student] = [
    Student(id: "S001", name: "An", gpa: 8.5),
    Student(id: "S002", name: "Binh", gpa: 7.8),
    Student(id: "S003", name: "Chi", gpa: 9.2),
    Student(id: "S004", name: "Duy", gpa: 9.2),
    Student(id: "S005", name: "Lan", gpa: 8.0)
]
