//
//  SubjectsView.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import SwiftUI

struct SubjectsView: View {
    @ObservedObject var viewModel: ClassManagerViewModel
    @State private var showingAddSubject = false
    @State private var subjectId = ""
    @State private var subjectName = ""
    @State private var credits = "3"

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Semester Subjects")) {
                    ForEach(viewModel.subjects) { subject in
                        VStack(alignment: .leading) {
                            Text(subject.name).font(.headline)
                            Text("Code: \(subject.id) • Credits: \(subject.credits)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section(header: Text("Instructors & Qualified Subjects")) {
                    ForEach(viewModel.teachers) { teacher in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(teacher.name).font(.headline)
                            Text("Can Teach:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            ForEach(teacher.subjectsCanTeach) { sub in
                                Text("• \(sub.name) (\(sub.id))")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Subjects & Faculty")
            .toolbar {
                Button(action: { showingAddSubject = true }) {
                    Image(systemName: "plus")
                }
            }
            .alert("Add New Subject", isPresented: $showingAddSubject) {
                TextField("Subject ID (e.g. PH062IU)", text: $subjectId)
                TextField("Subject Name", text: $subjectName)
                TextField("Credits", text: $credits)
                Button("Add") {
                    if let credInt = Int(credits) {
                        viewModel.addSubject(id: subjectId, name: subjectName, credits: credInt)
                    }
                    subjectId = ""; subjectName = ""
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }
}