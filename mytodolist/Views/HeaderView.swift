//
//  HeaderView.swift
//  mytodolist
//
//  Created by Saravanan Saminathan on 7/4/24.
//

import SwiftUI

struct HeaderView: View {
    let title : String;
    let subTitle : String;
    let backgroundColor : Color;
    let angle : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(backgroundColor)
                .rotationEffect(Angle(degrees: angle))
            
            
            VStack {
                Text(title)
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .bold()
                
                Text(subTitle)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
            }
            .padding(.top, 50)
        }
        .frame(width: UIScreen.main.bounds.width * 3, height: 350)
        .offset(y:-150)
    }
}

#Preview {
    HeaderView(title: "To Do List", subTitle: "Get things done", backgroundColor: Color.red, angle: 15)
}
