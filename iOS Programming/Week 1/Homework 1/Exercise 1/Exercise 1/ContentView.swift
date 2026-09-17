import SwiftUI

struct ContentView: View {
    let name: String = "Tran Phuong Ha"
    let studentID: String = "SESEIU24007"
    let gpa: Double = 9.9
    let status: String = "Active"
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Image(systemName: "h.circle.fill")
                    .resizable()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.mint.opacity(0.85))
            }
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.bold)
                    Spacer()
                    Text(status)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.green)
                        .clipShape(Capsule())
                }
                Text("Student ID: \(studentID)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack(spacing: 6) {
                    Image(systemName: "chart.bar.fill")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text("GPA: \(String(format: "%.1f", gpa))")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
