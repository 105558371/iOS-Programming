import SwiftUI

struct AddComputerView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var computers: [Computer]
    @State private var computerName: String = ""
    @State private var location: String = "Lab A"
    @State private var isAvailable: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "desktopcomputer")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                TextField("Enter computer name (e.g. PC06)", text: $computerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter location (e.g. Lab A)", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Toggle("Available", isOn: $isAvailable)
                
                Button(action: {
                    if !computerName.isEmpty {
                        let newComputer = Computer(name: computerName,
                                                   location: location,
                                                   isAvailable: isAvailable)
                        computers.append(newComputer)
                        dismiss()
                    }
                }) {
                    Text("Add")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .navigationTitle("Add Computer")
            .navigationBarBackButtonHidden(false)
        }
    }
}
