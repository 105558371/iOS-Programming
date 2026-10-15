import Foundation

class Fish: Identifiable {
    var id: Int
    private var name: String
    private var color: String
    private var price: Double
    
    init(id: Int, name: String, color: String, price: Double) {
        self.id = id
        self.name = name
        self.color = color
        self.price = price
    }
    
    // Direct Getters to safely access properties without parsing strings
    func getName() -> String { return name }
    func getColor() -> String { return color }
    func getPrice() -> Double { return price }
    
    func getInfo() -> String {
        return "\(id) \(name) - \(color) - $\(price)"
    }
    
    func setName(_ newName: String) {
        self.name = newName
    }
}
