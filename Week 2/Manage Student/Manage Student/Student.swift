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

// Add a New Student (append)
func addStudent(newStudent: Student) {
    students.append(newStudent)
}

// Remove Student by ID (removeAll)
func removeStudent(id: String) {
    students.removeAll { $0.id == id }
}

// Update Student GPA (firstIndex)
func updateGPA(id: String, newGPA: Double) {
    if let index = students.firstIndex(where: { $0.id == id }) {
        students[index].gpa = newGPA
    }
}

// Find Student by Name (first)
func findStudent(name: String) -> Student? {
    return students.first(where: { $0.name.lowercased() == name.lowercased() })
}

// Find Student with Highest GPA (max)
var topStudent: Student? {
    return students.max(by: { $0.gpa < $1.gpa })
}

// Filter High Performers (GPA >= 8.0)
var honorStudents: [Student] {
    return students.filter { $0.gpa >= 8.0 }
}

// Sort Students by GPA Descending (sorted)
var sortedStudents: [Student] {
    return students.sorted(by: { $0.gpa > $1.gpa })
}
