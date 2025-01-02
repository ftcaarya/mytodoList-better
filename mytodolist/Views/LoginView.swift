//
//  LoginView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(AppState.self) private var appState : AppState
    
    @StateObject var loginviewModel = LoginViewModel()
    
//    @StateObject var loginviewModel: FirstViewModel
    
//    init() {
//       _viewModel = StateObject<FirstViewModel>(wrappedValue: FirstViewModel(counter: counter))
//    }
    
    var body: some View {
        ActivityIndicatorView(isShowing : $loginviewModel.loading) {
            NavigationStack {
                VStack {
                    //Header
                    HeaderView(title: "To Do List", subTitle: "Get things done", backgroundColor: Color.mint, angle: 15)
                    
                    //Login
                    Form {
                        if !loginviewModel.errorMessage.isEmpty {
                            Text(loginviewModel.errorMessage)
                                .foregroundStyle(.red)
                        }
                        TextField("Email Address", text: $loginviewModel.emailId)
                            .textFieldStyle(DefaultTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                        SecureField("Password", text: $loginviewModel.password)
                            .textFieldStyle(DefaultTextFieldStyle())
                        
                        TodoButton(title: "Login",
                                   background: .blue, isUserLogedin: $loginviewModel.isUserLogedIn) {
                            Task{
                                await loginviewModel.login()
                                self.appState.user.userId  = loginviewModel.emailId
                                print(self.appState.user.userId ?? "")
                            }
                        }.padding()
                    }
                    .frame(maxHeight: 250)
//                    .scrollContentBackground(.hidden)
                    .offset(y: -50)
                    Spacer()
                    
                    //Create Account
                    VStack {
                        Text("New around here?")
                        NavigationLink("Create an account", destination: RegistrationView())
                       
                    }.padding(.bottom, 50)
                
                    Spacer()
                } .onDisappear {
                    self.appState.user  = loginviewModel.user;
                    self.appState.isUserLogedIn = loginviewModel.isUserLogedIn
                    print("ContentView disappeared!")
                }
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(AppState())
}
