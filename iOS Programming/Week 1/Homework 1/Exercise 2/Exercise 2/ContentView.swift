import SwiftUI

struct ContentView: View {
    let name: String = "Tran Phuong Ha"
    let motto: String = "Always learning, always growing ♡"
    let studentID: String = "SESEIU24007"
    let age: Int = 20
    let gpa: Double = 9.9
    let isStudent: Bool = true
    let quote: String = "\"Better me, a brighter tomorrow!\""
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 16) {
                    ZStack(alignment: .bottom) {
                        ZStack(alignment: .topTrailing) {
                            Image("Cover")
                                .resizable()
                                .scaledToFill()
                                .frame(height: 190)
                                .clipped()
                        }
                        .padding(.bottom, 40)
                        
                        ZStack {
                            Image(systemName: "h.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.white, .indigo.opacity(0.85))
                        }
                    }
                    
                    VStack(spacing: 4) {
                        Text(name)
                            .font(.title)
                            .fontWeight(.bold)
                        Text(motto)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding(.bottom, 55)
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            InfoCard(icon: "person.fill", title: "Student ID", value: studentID, color: .blue)
                            InfoCard(icon: "chart.bar.fill", title: "Age", value: "\(age)", color: .red)
                        }
                        HStack(spacing: 12) {
                            InfoCard(icon: "chart.bar.xaxis", title: "GPA", value: String(format: "%.1f", gpa), color: .green)
                            InfoCard(icon: "graduationcap.fill", title: "Student", value: isStudent ? "true" : "false", color: .purple)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 15)
                    
                    HStack {
                        Image(systemName: "quote.opening")
                            .foregroundColor(.orange)
                        Text(quote)
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(.orange)
                        Image(systemName: "sparkles")
                            .foregroundColor(.green)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(20)
                    .padding(.bottom, 40)
                    
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "paperplane")
                            Text("Edit Profile")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.teal)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.top, 4)
                }
            }
                        
            HStack {
                Spacer()
                TabItem(icon: "house.fill", title: "Profile", isActive: true)
                Spacer()
                TabItem(icon: "book.fill", title: "Subjects", isActive: false)
                Spacer()
                TabItem(icon: "gearshape.fill", title: "Settings", isActive: false)
                Spacer()
            }
            .padding(.top, 8)
            .background(Color(.systemBackground))
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding()
        .background(color.opacity(0.12))
        .cornerRadius(12)
    }
}

struct TabItem: View {
    let icon: String
    let title: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
            Text(title)
                .font(.caption2)
        }
        .foregroundColor(isActive ? .teal : .gray)
    }
}

#Preview {
    ContentView()
}
