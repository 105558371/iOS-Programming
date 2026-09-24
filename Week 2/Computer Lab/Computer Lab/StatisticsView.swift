import SwiftUI

struct StatisticsView: View {
    let computers: [Computer]
    
    var totalCount: Int {
        computers.count
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "chart.bar.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                    .padding(.top, 10)
                
                // Total count card
                HStack(spacing: 16) {
                    Image(systemName: "desktopcomputer")
                        .font(.system(size: 28))
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text("Total Computers")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("\(totalCount)")
                            .font(.system(size: 28, weight: .bold))
                    }
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                
                // List of computers
                List(computers) { computer in
                    HStack {
                        Image(systemName: "desktopcomputer")
                        
                        VStack(alignment: .leading) {
                            Text(computer.name)
                                .font(.headline)
                            Text(computer.location)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Circle()
                            .fill(computer.isAvailable ? Color.green : Color.red)
                            .frame(width: 10, height: 10)
                        
                        Text(computer.isAvailable ? "Available" : "In Use")
                            .foregroundColor(computer.isAvailable ? .green : .red)
                    }
                }
            }
            .navigationTitle("Statistics")
            .navigationBarBackButtonHidden(false)
        }
    }
}
