//
//  APIRequest.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import Foundation

//Login Request
struct LoginRequest: Codable {
  var userId: String?
  var password: String?
}

//Signup Request
struct SignupRequest: Codable {
    var fullName :String?
    var userId: String?
    var password: String?
    var status: String?
}

//Signup Response
struct SignupResponse: Codable {
    var status: String?
    var message: String?
    var data : User
}

//AddTask Response
struct AddTaskResponse: Codable {
    var status: String?
    var message: String?
    var data : TodoItem
}

//deleteTask Response
struct DeleteTaskResponse: Codable {
    var status: String?
    var message: String?
    var data : String?
}
