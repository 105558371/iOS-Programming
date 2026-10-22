//
//  StudentRecord.swift
//  PracticeTest
//
//  Created by SESEIU24007 on 22/10/26.
//


import Foundation

class StudentRecord: Identifiable {
    var id = UUID()
    var student: Student
    var subject: Subject
    private var _mark: Double
    
    // Getter and Setter with validation (0.0 to 10.0)
    var mark: Double {
        get { return _mark }
        set {
            if newValue >= 0.0 && newValue <= 10.0 {
                _mark = newValue
            } else {
                print("Error: Mark must be between 0 and 10.")
            }
        }
    }
    
    init(student: Student, subject: Subject, mark: Double) {
        self.student = student
        self.subject = subject
        self._mark = max(0.0, min(10.0, mark))
    }
    
    func isPassed() -> Bool {
        return _mark >= 5.0
    }
}