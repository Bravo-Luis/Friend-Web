//
//  loginScreen.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/16/22.
//

import SwiftUI

struct loginScreen: View {
    @ObservedObject var icvm : CloudKitUserViewModel
    @State var username : String = ""
    @State var password : String = ""
    
    @State var ScreenHeight = UIScreen.main.bounds.height
    @State var ScreenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            Spacer()
            Group{
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            .font(.system(size: ScreenHeight / 20 ))
            Button(action: {
                icvm.login(usernameText: username, password: password)
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemBlue))
                    Text("Login")
                        .font(.system(size: ScreenHeight / 20 ))
                        .foregroundColor(.white)
                }
                .frame(width: ScreenWidth * 0.8, height: ScreenHeight / 15)
                    
            }
            Spacer()
        }
        .frame(width: ScreenWidth * 0.8)
    }
}

