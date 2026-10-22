import Foundation
import Combine

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
