//
//  RegistrationViewModel.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import Foundation


class RegistrationViewModel : ObservableObject {
    @Published var name : String  = "Full Name Test"
    @Published var emailId : String  = "test@gmail.com"
    @Published var password : String  = "test"
    @Published var errorMessage = ""
    @Published var isUserLogedIn = false;
    @Published var loading = false;
    @Published var user = User(userId: "Empty", id: "Empty", status: "Empty", fullName: "Empty", password: "Empty")
    
    init(){
        
    }
    
//    func signupv1(completion: @escaping (Result<User, NetworkError>) -> Void) {
//        let signupRequestData = SignupRequest(fullName: name, userId : emailId, password: password, status : "Active")
//        self.loading = true;
//        WebService().signup(signupRequestData: signupRequestData) { result in
//            switch result {
//            case .failure(let error):
//                self.loading = false;
//                print("<error>", error)
//                self.errorMessage = ""
//                if(error == NetworkError.duplicateEmailid) {
//                    self.errorMessage = "Email id already exists"
//                }
//            case .success(let user):
//                self.loading = false;
//                print("<Created user>", user)
//                if(user.userId == nil) {
//                    self.errorMessage = ""
//                    self.errorMessage = "Account Creation Failed"
//                    self.isUserLogedIn = false
//                }else {
//                    self.errorMessage = ""
//                    self.isUserLogedIn = true
//                    self.user = user
//                }
//            }
//        }
//    }
    
    func signup() {
        print("Inside signup ..")
        guard validate() else {
            return
        }
        
        //Call API
        let signupRequestData = SignupRequest(fullName: name, userId : emailId, password: password, status : "Active")
        self.loading = true;
        WebService().signup(signupRequestData: signupRequestData) { result in
                switch result {
                case .failure(let error):
                    self.loading = false;
                    print("<error>", error)
                    self.errorMessage = ""
                    if(error == NetworkError.duplicateEmailid) {
                        self.errorMessage = "Email id already exists"
                    }
                case .success(let user):
                    self.loading = false;
                    print("<Created user>", user)
                    if(user.userId == nil) {
                        self.errorMessage = ""
                        self.errorMessage = "Account Creation Failed"
                        self.isUserLogedIn = false
                    }else {
                        self.errorMessage = ""
                        self.isUserLogedIn = true
                        self.user = user
                    }
                }
            }
    }
    
    func validate() -> Bool {
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !emailId.trimmingCharacters(in: .whitespaces).isEmpty,
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
