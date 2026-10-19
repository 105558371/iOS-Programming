import SwiftUI

@main
struct PracticeTestApp: App {
    var body: some Scene {
        WindowGroup {
            StudentListView()
        }
    }
}

struct StudentListView: View {
    @StateObject private var manager = UniversityManager()
    
    var body: some View {
        NavigationView {
            List(manager.students) { student in
                NavigationLink(destination: StudentDetailView(manager: manager, student: student)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(student.name)
                            .font(.headline)
                        Text("ID: \(student.id) | Age: \(student.age)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        let avg = manager.calculateWeightedAverage(for: student)
                        let rank = manager.getAcademicRanking(for: student)
                        
                        HStack {
                            Text(String(format: "Avg: %.2f", avg))
                            Spacer()
                            Text("Rank: \(rank)")
                                .fontWeight(.bold)
                                .foregroundColor(rankColor(rank))
                        }
                        .font(.caption)
                        .padding(.top, 2)
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("University Students")
        }
    }
    
    func rankColor(_ rank: String) -> Color {
        switch rank {
        case "Excellent": return .purple
        case "Good": return .blue
        case "Average": return .orange
        default: return .red
        }
    }
}

struct StudentDetailView: View {
    @ObservedObject var manager: UniversityManager
    var student: Student
    
    @State private var selectedRecord: StudentRecord?
    @State private var newMarkText: String = ""
    @State private var showingEditSheet = false
    
    var body: some View {
        VStack {
            // Student Info Header
            VStack(alignment: .leading, spacing: 6) {
                Text(student.displayInfo())
                    .font(.subheadline)
                let avg = manager.calculateWeightedAverage(for: student)
                let rank = manager.getAcademicRanking(for: student)
                Text("Weighted Average: \(String(format: "%.2f", avg)) - Ranking: \(rank)")
                    .font(.headline)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            
            // List of Subjects & Marks
            List {
                Section(header: Text("Registered Subjects")) {
                    let studentRecords = manager.records.filter { $0.student.id == student.id }
                    if studentRecords.isEmpty {
                        Text("No subjects registered.")
                    } else {
                        ForEach(studentRecords) { record in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(record.subject.name)
                                        .font(.body)
                                    Text("Credits: \(record.subject.credits)")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(String(format: "Mark: %.1f", record.mark))
                                        .fontWeight(.semibold)
                                    Text(record.isPassed() ? "Passed" : "Failed")
                                        .font(.caption)
                                        .foregroundColor(record.isPassed() ? .green : .red)
                                }
                                Button("Edit") {
                                    selectedRecord = record
                                    newMarkText = "\(record.mark)"
                                    showingEditSheet = true
                                }
                                .buttonStyle(.bordered)
                                .font(.caption)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Student Details")
        .sheet(isPresented: $showingEditSheet) {
            if let record = selectedRecord {
                EditMarkView(record: record, markText: $newMarkText, isPresented: $showingEditSheet) {
                    // Refresh trigger
                    manager.objectWillChange.send()
                }
            }
        }
    }
}

struct EditMarkView: View {
    var record: StudentRecord
    @Binding var markText: String
    @Binding var isPresented: Bool
    var onUpdate: () -> Void
    
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Update Mark for \(record.subject.name)")) {
                    TextField("New Mark (0-10)", text: $markText)
                        .keyboardType(.decimalPad)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .navigationTitle("Edit Mark")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let val = Double(markText), val >= 0.0, val <= 10.0 {
                            record.mark = val
                            onUpdate()
                            isPresented = false
                        } else {
                            errorMessage = "Please enter a valid mark between 0 and 10."
                        }
                    }
                }
            }
        }
    }
}
