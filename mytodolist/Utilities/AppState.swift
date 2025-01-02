//
//  AppSettings.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/8/24.
//

import Foundation

// Our observable object class
@Observable class AppState {
    var user = User(userId: "sar762009@gmail.com", id: "Empty", status: "Empty", fullName: "Empty", password: "Empty")
    var isUserLogedIn : Bool = false
}
