import SwiftUI

struct CheckComputerView: View {
    let computers: [Computer]
    
    @State private var searchName: String = ""
    @State private var searchResult: String? = nil
    @State private var isFound: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "desktopcomputer")
                .font(.system(size: 60))
                .foregroundColor(.blue)
                .padding(.top, 20)
            
            TextField("Enter computer name (e.g. PC03)", text: $searchName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.allCharacters)
                .padding(.horizontal)
            
            Button(action: checkComputer) {
                Text("Check")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .padding(.horizontal)
            
            if let result = searchResult {
                HStack {
                    Image(systemName: isFound ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(isFound ? .green : .red)
                    Text(result)
                        .font(.headline)
                        .foregroundColor(isFound ? .green : .red)
                }
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Check Computer")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func checkComputer() {
        let trimmedQuery = searchName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return }
        
        if computers.contains(where: { $0.name.lowercased() == trimmedQuery.lowercased() }) {
            isFound = true
            searchResult = "\(trimmedQuery.uppercased()) is in the lab!"
        } else {
            isFound = false
            searchResult = "\(trimmedQuery.uppercased()) is not in the lab!"
        }
    }
}

#Preview {
    NavigationStack {
        CheckComputerView(computers: [
            Computer(name: "PC01", location: "Lab A", isAvailable: true),
            Computer(name: "PC02", location: "Lab A", isAvailable: true)
        ])
    }
}
