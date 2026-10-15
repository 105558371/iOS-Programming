//
//  StudentSubject.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import Foundation

struct StudentSubject: Identifiable, Codable {
    let id = UUID()
    var idStudent: String
    var idSubject: String
    var grade: Double // Mark/grade (0.0 - 10.0 scale)
    
    var isFailed: Bool {
        return grade < 5.0 // Threshold for failing a subject
    }
}