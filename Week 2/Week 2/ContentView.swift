import SwiftUI

struct ContentView: View {
    @State private var computers: [Computer] = [
        Computer(name: "PC01", location: "Lab A", isAvailable: true),
        Computer(name: "PC02", location: "Lab A", isAvailable: true),
        Computer(name: "PC03", location: "Lab B", isAvailable: false),
        Computer(name: "PC04", location: "Lab B", isAvailable: true),
        Computer(name: "PC05", location: "Lab C", isAvailable: true)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                Text("Computer Lab")
                    .font(.title2).bold()
                Text("Manage computers easily")
                    .foregroundColor(.gray)
                
                List(computers) { computer in
                    HStack {
                        Image(systemName: "desktopcomputer")
                            .foregroundColor(.gray)
                        VStack(alignment: .leading) {
                            Text(computer.name)
                            Text(computer.location)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        HStack(spacing: 6) {
                            Circle()
                                .fill(computer.isAvailable ? Color.green : Color.red)
                                .frame(width: 10, height: 10)
                            Text(computer.isAvailable ? "Available" : "In Use")
                                .foregroundColor(computer.isAvailable ? .green : .red)
                        }
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                
                Button(action: {
                    // TODO: Navigate to AddComputerView
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Computer")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)
                
                Text("Total computers: \(computers.count)")
            }
            .navigationTitle("")
        }
    }
}

#Preview {
    ContentView()
}
