//
//  TodoItem.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import Foundation


struct TodoItem: Identifiable, Codable {
    let id: String?
    let taskName: String
    let taskNotes: String
    let userId: String
    let status: String
    let targetDate: String
}


