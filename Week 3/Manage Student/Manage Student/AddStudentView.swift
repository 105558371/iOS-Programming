import SwiftUI

struct AddStudentView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var students: [Student]

    @State private var id: String = ""
    @State private var name: String = ""
    @State private var gpaText: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Student Information")) {
                    TextField("Student ID (e.g. S006)", text: $id)
                    TextField("Name (e.g. An)", text: $name)
                    TextField("GPA (e.g. 8.5)", text: $gpaText)
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Add Student")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if let gpa = Double(gpaText), !id.isEmpty, !name.isEmpty {
                            let newStudent = Student(id: id, name: name, gpa: gpa)
                            students.append(newStudent)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
