//
//  LoginViewModel.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import Foundation

class LoginViewModel : ObservableObject {

    @Published var emailId : String  = "sar762009@gmail.com"
    @Published var password : String  = "test1234"
    @Published var user = User(userId: "Empty", id: "Empty", status: "Empty", fullName: "Empty", password: "Empty")
    @Published var errorMessage = ""
    @Published var isUserLogedIn = false;
    @Published var loading = false;
    
    init() {
       
    }
    
    func login() async {
        guard validate() else {
            return
        }
        //Call API
        let loginData = LoginRequest(userId : emailId, password: password)
        self.loading = true;
           WebService().login(loginRequest: loginData) { result in
                switch result {
                case .failure(let error):
                    self.loading = false;
                    print("<error>", error)
                case .success(let data):
                    self.loading = false;
                    print("<data>", data.count)
                    if(data.count == 0) {
                        self.errorMessage = ""
                        self.errorMessage = "Invalid userid/password"
                        self.isUserLogedIn = false
                    }else {
                        self.errorMessage = ""
                        self.isUserLogedIn = true
                        self.user = data[0]
                    }
                }
            }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !emailId.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard emailId.contains("@") && emailId.contains(".") else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        return true
        
    }
    
}
