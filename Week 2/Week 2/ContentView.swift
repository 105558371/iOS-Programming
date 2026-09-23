import SwiftUI

struct ContentView: View {
    @State private var computers: [Computer] = [
        Computer(name: "PC01", location: "Lab A", isAvailable: true),
        Computer(name: "PC02", location: "Lab A", isAvailable: true),
        Computer(name: "PC03", location: "Lab B", isAvailable: false),
        Computer(name: "PC04", location: "Lab B", isAvailable: true),
        Computer(name: "PC05", location: "Lab C", isAvailable: true)
    ]
    
    @State private var showingAddSheet = false

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
                    NavigationLink(destination: ComputerView(computer: computer)) {
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
                        }
                    }
                }
                
                // Action buttons
                HStack(spacing: 12) {
                    NavigationLink(destination: CheckComputerView(computers: computers)) {
                        Label("Check", systemImage: "magnifyingglass")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                    NavigationLink(destination: StatisticsView(computers: computers)) {
                        Label("Stats", systemImage: "chart.bar.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                
                Button(action: {
                    showingAddSheet = true
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
            .sheet(isPresented: $showingAddSheet) {
                AddComputerView(computers: $computers)
            }
        }
    }
}

struct ComputerView: View {
    let computer: Computer

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "desktopcomputer")
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text(computer.name)
                .font(.largeTitle)
                .bold()
            
            Text("Location: \(computer.location)")
                .font(.title3)
                .foregroundColor(.secondary)
            
            HStack {
                Circle()
                    .fill(computer.isAvailable ? Color.green : Color.red)
                    .frame(width: 12, height: 12)
                Text(computer.isAvailable ? "Available" : "In Use")
                    .font(.headline)
                    .foregroundColor(computer.isAvailable ? .green : .red)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(computer.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
