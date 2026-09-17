import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                //.opacity(0.85)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 120, height: 120)
                        .shadow(color: Color.blue.opacity(0.3), radius: 12, x: 0, y: 6)
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: 108, height: 108)
                    
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 58, height: 58)
                        .foregroundColor(Color(red: 0.1, green: 0.25, blue: 0.6))
                }
                
                Text("Student Profile")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color.white)
                    .shadow(color: Color.black.opacity(1.0), radius: 10, x: 0, y: 1)
                    .padding(.bottom, 50)
                
                VStack(spacing: 15) {
                    ProfileRow(icon: "person.fill", title: "Name", value: "Tran Phuong Ha")
                    ProfileRow(icon: "creditcard.fill", title: "Student ID", value: "SESEIU24007")
                    ProfileRow(icon: "calendar", title: "Age", value: "20")
                    ProfileRow(icon: "chart.bar.fill", title: "GPA", value: "9.9")
                    ProfileRow(icon: "checkmark.circle.fill", title: "Student", value: "True")
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
                .background(Color.white)
                .cornerRadius(22)
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

struct ProfileRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.blue)
                .frame(width: 28, height: 28)
            
            Text(title)
                .font(.body)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .bold()
                .foregroundColor(title == "Student" ? .green : Color(red: 0.1, green: 0.1, blue: 0.2))
        }
    }
}

#Preview {
    ContentView()
}
