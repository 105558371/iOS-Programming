//
//  Subject.swift
//  School Management
//
//  Created by SESEIU24007 on 15/10/26.
//


import Foundation

struct Subject: Identifiable, Codable, Hashable {
    let id: String // Subject Code (e.g., PH062IU)
    var name: String
    var credits: Int
}