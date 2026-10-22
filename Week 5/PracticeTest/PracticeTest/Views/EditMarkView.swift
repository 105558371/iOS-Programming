//
//  EditMarkView.swift
//  PracticeTest
//
//  Created by SESEIU24007 on 22/10/26.
//


import SwiftUI

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