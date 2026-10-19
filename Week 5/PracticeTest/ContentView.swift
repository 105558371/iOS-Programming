import Foundation
import Combine

// MARK: - Student Class
class Student: Identifiable, ObservableObject {
    @Published var id: String
    @Published var name: String
    @Published var age: Int
    
    init(id: String, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
    
    func displayInfo() -> String {
        return "ID: \(id) | Name: \(name) | Age: \(age)"
    }
}

// MARK: - Subject Class
class Subject: Identifiable {
    var id: String
    var name: String
    var credits: Int
    
    init(id: String, name: String, credits: Int) {
        self.id = id
        self.name = name
        self.credits = credits
    }
}

// MARK: - StudentRecord Class
class StudentRecord: Identifiable {
    var id = UUID()
    var student: Student
    var subject: Subject
    private var _mark: Double
    
    // Getter and Setter with validation (0.0 to 10.0)
    var mark: Double {
        get { return _mark }
        set {
            if newValue >= 0.0 && newValue <= 10.0 {
                _mark = newValue
            } else {
                print("Error: Mark must be between 0 and 10.")
            }
        }
    }
    
    init(student: Student, subject: Subject, mark: Double) {
        self.student = student
        self.subject = subject
        self._mark = max(0.0, min(10.0, mark)) // Clamp initial value
    }
    
    func isPassed() -> Bool {
        return _mark >= 5.0
    }
}
