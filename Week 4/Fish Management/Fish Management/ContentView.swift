import SwiftUI

struct ContentView: View {
    @State private var fishes: [Fish] = [
        Fish(id: 1, name: "Neon Fish", color: "Red", price: 20.0),
        Fish(id: 2, name: "Betta Fish", color: "Blue", price: 35.0),
        Fish(id: 3, name: "Goldfish", color: "Orange", price: 25.0),
        Fish(id: 4, name: "Angelfish", color: "Silver", price: 40.0)
    ]
    
    var body: some View {
        TabView {
            // MARK: - Fishes Tab
            NavigationStack {
                ZStack {
                    // Light background color matching iOS grouped lists
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                    
                    List(fishes) { fish in
                        HStack(spacing: 16) {
                            // Fish Icon / Illustration placeholder
                            Image(systemName: "fish.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(fishColor(for: fish.getColor()))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(fish.getName())
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Text("\(fish.getColor()) - $\(String(format: "%.1f", fish.getPrice()))")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            // Chevron disclosure indicator
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Color(.systemGray3))
                        }
                        .padding(.vertical, 4)
                    }
                    .scrollContentBackground(.hidden)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Centers the title
                    ToolbarItem(placement: .principal) {
                        Text("My Aquarium")
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    // Keeps the plus button on the right
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .tabItem {
                Label("Fishes", systemImage: "fish.fill")
            }
            
            // MARK: - Statistics Tab (Placeholder UI)
            NavigationStack {
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    VStack(spacing: 12) {
                        Image(systemName: "chart.bar.xaxis")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        Text("Aquarium Statistics")
                            .font(.title2)
                            .bold()
                        Text("Statistics view preview")
                            .foregroundColor(.secondary)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Statistics")
                            .font(.largeTitle)
                            .bold()
                    }
                }
            }
            .tabItem {
                Label("Statistics", systemImage: "chart.bar.xaxis")
            }
        }
        .tint(.blue)
    }
    
    // Helper to give icons a nice matching tint based on color string
    func fishColor(for colorStr: String) -> Color {
        switch colorStr.lowercased() {
        case "red": return .red
        case "blue": return .blue
        case "orange": return .orange
        case "silver": return .gray
        default: return .blue
        }
    }
}

#Preview {
    ContentView()
}
