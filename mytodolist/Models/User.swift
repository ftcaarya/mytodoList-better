//
//  User.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import Foundation


struct User: Identifiable, Codable {
    var userId: String?
    var id: String?
    var status: String?
    var fullName: String?
    var password: String?
}
        
