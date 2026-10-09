import SwiftUI

enum GPASortOption: String, CaseIterable, Identifiable {
    case none = "Default"
    case highestToLowest = "High → Low"
    case lowestToHighest = "Low → High"

    var id: String { self.rawValue }
}

struct ContentView: View {
    @State private var students: [Student] = [
        Student(id: "S001", name: "An", gpa: 8.5),
        Student(id: "S002", name: "Binh", gpa: 7.8),
        Student(id: "S003", name: "Chi", gpa: 9.2),
        Student(id: "S004", name: "Duy", gpa: 9.2),
        Student(id: "S005", name: "Lan", gpa: 8.0)
    ]
    
    @State private var searchText: String = ""
    @State private var sortOption: GPASortOption = .none
    @State private var isShowingAddSheet: Bool = false
    @State private var studentToEdit: Student? = nil

    // Search filter and GPA sorting
    var processedStudents: [Student] {
        var result = students
        
        if !searchText.isEmpty {
            result = result.filter { student in
                student.name.localizedCaseInsensitiveContains(searchText) ||
                student.id.localizedCaseInsensitiveContains(searchText)
            }
        }

        switch sortOption {
        case .highestToLowest:
            return result.sorted { $0.gpa > $1.gpa }
        case .lowestToHighest:
            return result.sorted { $0.gpa < $1.gpa }
        case .none:
            return result
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Header
                Image(systemName: "person.3.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                Text("Student Manager")
                    .font(.title2).bold()
                
                Text("A better class, a brighter tomorrow")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search by name or student ID...", text: $searchText)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                // Sort by GPA Control Section
                HStack(spacing: 8) {
                    Text("Sort by GPA:")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)

                    Spacer()

                    ForEach(GPASortOption.allCases) { option in
                        Button(action: { sortOption = option }) {
                            Text(option.rawValue)
                                .font(.caption2)
                                .fontWeight(sortOption == option ? .bold : .regular)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(sortOption == option ? Color.blue : Color(.systemGray5))
                                .foregroundColor(sortOption == option ? .white : .primary)
                                .cornerRadius(6)
                        }
                    }
                }
                .padding(.horizontal)
                Spacer()

                // Student List
                List {
                    ForEach(processedStudents) { student in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(student.name)
                                    .font(.headline)
                                Text("GPA: \(student.gpa, specifier: "%.1f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            
                            Text(student.id)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)

                            Button(action: {
                                studentToEdit = student
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .onDelete(perform: deleteStudent)
                }
                .listStyle(.plain)

                // Footer Actions
                VStack(spacing: 8) {
                    Button(action: {
                        isShowingAddSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Student")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    Text("Total students: \(students.count)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
            .navigationTitle("")
            .sheet(isPresented: $isShowingAddSheet) {
                AddStudentView(students: $students)
            }
            .sheet(item: $studentToEdit) { student in
                EditStudentView(student: .constant(student)) { updatedStudent in
                    updateStudent(updatedStudent)
                }
            }
        }
    }

    private func deleteStudent(at offsets: IndexSet) {
        let itemsToDelete = offsets.map { processedStudents[$0] }
        students.removeAll { student in
            itemsToDelete.contains(where: { $0.id == student.id })
        }
    }

    private func updateStudent(_ updatedStudent: Student) {
        if let index = students.firstIndex(where: { $0.id == updatedStudent.id }) {
            students[index] = updatedStudent
        }
    }
}
