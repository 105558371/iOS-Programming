import SwiftUI

struct GradesView: View {
    @ObservedObject var viewModel: ClassManagerViewModel
    @State private var selectedStudentId: String = ""
    @State private var selectedSubjectId: String = ""
    @State private var gradeInput: String = ""
    @State private var showingEnrollSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.students) { student in
                    Section(header: Text("\(student.name) (\(student.id))")) {
                        StudentGradesSection(
                            student: student,
                            viewModel: viewModel,
                            selectedStudentId: $selectedStudentId,
                            selectedSubjectId: $selectedSubjectId,
                            gradeInput: $gradeInput,
                            showingEnrollSheet: $showingEnrollSheet
                        )
                    }
                }
            }
            .navigationTitle("Enrollment & Grades")
            .sheet(isPresented: $showingEnrollSheet) {
                NavigationStack {
                    Form {
                        Section(header: Text("Assign / Update Grade")) {
                            Picker("Subject", selection: $selectedSubjectId) {
                                ForEach(viewModel.subjects) { sub in
                                    Text(sub.name).tag(sub.id)
                                }
                            }
                            TextField("Grade (0 - 10)", text: $gradeInput)
                                .keyboardType(.decimalPad)
                        }
                    }
                    .navigationTitle("Subject Grade Manager")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                if let gradeVal = Double(gradeInput) {
                                    viewModel.assignSubject(idStudent: selectedStudentId, idSubject: selectedSubjectId, grade: gradeVal)
                                    viewModel.updateGrade(idStudent: selectedStudentId, idSubject: selectedSubjectId, newGrade: gradeVal)
                                }
                                showingEnrollSheet = false
                            }
                        }
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") { showingEnrollSheet = false }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Helper Subview to Fix Type-Checking Timeout
struct StudentGradesSection: View {
    let student: Student
    @ObservedObject var viewModel: ClassManagerViewModel
    @Binding var selectedStudentId: String
    @Binding var selectedSubjectId: String
    @Binding var gradeInput: String
    @Binding var showingEnrollSheet: Bool

    var body: some View {
        let studentRecords = viewModel.studentSubjects.filter { $0.idStudent == student.id }
        
        if studentRecords.isEmpty {
            Text("No subjects assigned for this semester.")
                .font(.caption)
                .foregroundColor(.secondary)
        } else {
            ForEach(studentRecords) { record in
                HStack {
                    VStack(alignment: .leading) {
                        let subjectName = viewModel.subjects.first(where: { $0.id == record.idSubject })?.name ?? record.idSubject
                        Text(subjectName)
                            .font(.subheadline)
                        Text("Score: \(String(format: "%.1f", record.grade))")
                            .font(.caption)
                            .foregroundColor(record.isFailed ? .red : .green)
                    }
                    Spacer()
                    Button("Edit Grade") {
                        selectedStudentId = student.id
                        selectedSubjectId = record.idSubject
                        gradeInput = "\(record.grade)"
                        showingEnrollSheet = true
                    }
                    .font(.caption)
                    .buttonStyle(.bordered)
                }
            }
        }
        
        Button("Enroll Subject") {
            selectedStudentId = student.id
            selectedSubjectId = viewModel.subjects.first?.id ?? ""
            gradeInput = "0.0"
            showingEnrollSheet = true
        }
        .font(.caption)
        .foregroundColor(.blue)
    }
}
