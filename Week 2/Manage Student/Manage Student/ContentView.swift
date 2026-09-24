import SwiftUI

struct ContentView: View {
    @State private var students: [Student] = [
        Student(id: "S001", name: "An", gpa: 8.5),
        Student(id: "S002", name: "Binh", gpa: 7.8),
        Student(id: "S003", name: "Chi", gpa: 9.2),
        Student(id: "S004", name: "Duy", gpa: 9.2),
        Student(id: "S005", name: "Lan", gpa: 8.0)
    ]
    
    @State private var searchText: String = ""
    @State private var isShowingAddSheet: Bool = false

    // Computed property for search feature
    var filteredStudents: [Student] {
        if searchText.isEmpty {
            return students
        } else {
            return students.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Header Details
                Image(systemName: "person.3.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.blue)
                
                Text("Student Manager")
                    .font(.title2).bold()
                
                Text("A better class, a brighter tomorrow")
                    .font(.caption)
                    .foregroundColor(.gray)

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search student by name...", text: $searchText)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

                // Student List
                List {
                    ForEach(filteredStudents) { student in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(student.name)
                                    .font(.headline)
                                Text("GPA: \(student.gpa, specifier: "%.1f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text(student.id)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteStudent)
                }
                .listStyle(.plain)

                // Footer Actions & Stats
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
        }
    }

    // Delete handler for List swipe-to-delete
    private func deleteStudent(at offsets: IndexSet) {
        students.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
