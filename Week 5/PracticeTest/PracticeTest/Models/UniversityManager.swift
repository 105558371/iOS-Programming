//
//  UniversityManager.swift
//  PracticeTest
//
//  Created by SESEIU24007 on 22/10/26.
//


import Foundation
import Combine

class UniversityManager: ObservableObject {
    @Published var students: [Student] = []
    @Published var subjects: [Subject] = []
    @Published var records: [StudentRecord] = []
    
    init() {
        loadSampleData()
    }
    
    func loadSampleData() {
        // 1. Create 4 Students
        let s1 = Student(id: "SV001", name: "Nguyen Van A", age: 20)
        let s2 = Student(id: "SV002", name: "Tran Thi B", age: 21)
        let s3 = Student(id: "SV003", name: "Le Van C", age: 19)
        let s4 = Student(id: "SV004", name: "Pham Anh D", age: 22)
        students = [s1, s2, s3, s4]
        
        // 2. Create 4 Subjects
        let sub1 = Subject(id: "PH101", name: "iOS Programing", credits: 3)
        let sub2 = Subject(id: "PH102", name: "Remote Sensing", credits: 4)
        let sub3 = Subject(id: "IT103", name: "Database Management", credits: 3)
        let sub4 = Subject(id: "PH104", name: "Introduction to Space Engineering", credits: 3)
        subjects = [sub1, sub2, sub3, sub4]
        
        // 3. Create 8 Student Records (Avoiding duplicate subjects per student)
        records = [
            StudentRecord(student: s1, subject: sub1, mark: 8.5),
            StudentRecord(student: s1, subject: sub2, mark: 7.0),
            
            StudentRecord(student: s2, subject: sub1, mark: 4.5),
            StudentRecord(student: s2, subject: sub3, mark: 6.0),
            
            StudentRecord(student: s3, subject: sub2, mark: 9.5),
            StudentRecord(student: s3, subject: sub4, mark: 8.5),
            
            StudentRecord(student: s4, subject: sub3, mark: 5.5),
            StudentRecord(student: s4, subject: sub4, mark: 4.0)
        ]
    }
    
    // Weighted Average Calculation
    func calculateWeightedAverage(for student: Student) -> Double {
        let studentRecords = records.filter { $0.student.id == student.id }
        guard !studentRecords.isEmpty else { return 0.0 }
        
        let totalCredits = studentRecords.reduce(0) { $0 + $1.subject.credits }
        guard totalCredits > 0 else { return 0.0 }
        
        let weightedSum = studentRecords.reduce(0.0) { $0 + ($1.mark * Double($1.subject.credits)) }
        return weightedSum / Double(totalCredits)
    }
    
    // Academic Ranking Logic
    func getAcademicRanking(for student: Student) -> String {
        let avg = calculateWeightedAverage(for: student)
        if avg >= 9.0 { return "Excellent" }
        else if avg >= 8.0 { return "Good" }
        else if avg >= 7.0 { return "Fair" }
        else if avg >= 6.0 { return "Average" }
        else if avg >= 5.0 { return "Pass" }
        else { return "Fail" }
    }
    
    // Register subject with duplication check
    func registerSubject(student: Student, subject: Subject, mark: Double) -> Bool {
        let alreadyRegistered = records.contains { $0.student.id == student.id && $0.subject.id == subject.id }
        if alreadyRegistered {
            print("Duplicate registration prevented.")
            return false
        }
        let newRecord = StudentRecord(student: student, subject: subject, mark: mark)
        records.append(newRecord)
        objectWillChange.send()
        return true
    }
}
