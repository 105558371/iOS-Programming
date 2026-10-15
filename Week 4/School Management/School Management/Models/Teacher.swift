//
//  Teacher.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import Foundation

struct Teacher: Identifiable, Codable {
    let id: String
    var name: String
    var subjectsCanTeach: [Subject] // List of subjects the teacher can teach
}