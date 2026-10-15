//
//  Classroom.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import Foundation

struct Classroom: Identifiable, Codable {
    let id: UUID
    var className: String
    var subject: String
    var students: [Student]
    
    init(id: UUID = UUID(), className: String, subject: String, students: [Student] = []) {
        self.id = id
        self.className = className
        self.subject = subject
        self.students = students
    }
}