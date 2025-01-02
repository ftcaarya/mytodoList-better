//
//  RegistrationView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(AppState.self) private var appState : AppState
    @StateObject var registrationViewModel = RegistrationViewModel()
 
    var body: some View {
//        ActivityIndicatorView(isShowing : $registrationViewModel.loading) {
            NavigationStack {
                VStack {
                //Header
                HeaderView(title: "Registration", subTitle: "Start organizing todos", backgroundColor: Color.orange, angle: -15)
                
                //Signup
                Form {
                    if !registrationViewModel.errorMessage.isEmpty {
                        Text(registrationViewModel.errorMessage)
                            .foregroundStyle(.red)
                    }
                    TextField("Full Name", text: $registrationViewModel.name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                    TextField("Email Address", text: $registrationViewModel.emailId)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $registrationViewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TodoButton(title: "Create Account",
                               background: .blue, isUserLogedin: $registrationViewModel.isUserLogedIn) {
                        self.appState.user.userId  = registrationViewModel.emailId
                        registrationViewModel.signup()
                    }.padding()
                }
                .frame(maxHeight: 270)
                .offset(y: -50)
                Spacer()
                } .onDisappear {
                    self.appState.user  = registrationViewModel.user;
                    self.appState.isUserLogedIn = registrationViewModel.isUserLogedIn
                    print("ContentView disappeared!")
                }
            }
           
//        }
    }
}

#Preview {
    RegistrationView()
        .environment(AppState())
}
