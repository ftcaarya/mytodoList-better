//
//  TodoButtonView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct TodoButton: View {
    let title : String
    let background : Color
    @Binding var isUserLogedin: Bool
    let action : () -> Void
    
    var body: some View {
        Button{
            action()
        }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(background)
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                }
        }
        .navigationDestination(isPresented: self.$isUserLogedin, destination: {
            HomeTabView()
                .navigationBarBackButtonHidden(true)
        })
    }
}

#Preview {
    TodoButton(title: "Test", background: .pink, isUserLogedin : .constant(true)){
        //Action
    }
}
