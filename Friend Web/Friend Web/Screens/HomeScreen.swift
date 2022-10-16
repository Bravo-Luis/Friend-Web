//
//  HomeScreen.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/16/22.
//

import SwiftUI

struct HomeScreen: View {
    @ObservedObject var icvm = CloudKitUserViewModel()
    @State var inspecting = false
    @State var focus : UserModel = UserModel(username: "", password: "", age: 0, sex: "", firstName: "", lastName: "", description: "", friendsList: [String]())
    @State var settings = false
    
    var body: some View {
        
        ZStack{
            FriendGrid(inspecting: $inspecting, focus: $focus)
            Header(settings: $settings)
            
            if icvm.username != "" {
                profileView(focus: $focus, inspecting: $inspecting)
            }
            
        }
        .popover(isPresented: $settings, content: {
            Button("Log Out", role: .destructive, action: {
                UserDefaults.standard.set("", forKey: "username")
                icvm.username = ""
            })
            .buttonStyle(.borderedProminent)
        })
        .ignoresSafeArea()
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

struct Header : View {
    
    @State var height = UIScreen.main.bounds.height
    @State var width = UIScreen.main.bounds.width
    @State var animation = false
    @Binding var settings : Bool
    var body: some View {
        
        VStack{
            
            ZStack {
                Rectangle()
                    .fill(Color(.systemCyan))
                .frame(width: width, height: height / 6)
                HStack(spacing: width / 20){
                    Spacer(minLength: 0)
                    Text("Friend Web")
                        .font(.system(size: height / 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Button(action: {settings = true}){
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: height / 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.trailing, width / 10)
                    }
                        
                    
                }
                .padding(.top, height / 20)
            }
            .shadow(color:Color(.systemCyan),radius: 10)
            
            Spacer()
        }
        .offset(y: animation ? -5 : -height / 2)
        .animation(.spring(), value: animation)
        .onAppear{
            animation = true
        }
        
    }
    
}
