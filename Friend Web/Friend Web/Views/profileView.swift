//
//  profileView.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/16/22.
//

import SwiftUI

struct profileView: View {
    
    @State var height = UIScreen.main.bounds.height
    @State var width = UIScreen.main.bounds.width
    @Binding var focus : UserModel
    @Binding var inspecting : Bool

    var body: some View {
        
            
            
            ZStack {
                
                VStack{
                    Text(focus.firstName + " " + focus.lastName)
                        .font(.system(size: width / 10, weight: .bold))
                    Text(focus.age.formatted() + " " + focus.sex)
                        .font(.system(size: width / 15))
                    Text(focus.description)
                        .font(.system(size: width / 20))
                        .padding()
                }
                .blur(radius :inspecting ? 0 : 25)
                .multilineTextAlignment(.center)
                .animation(.easeIn.speed(0.75), value: inspecting)
                .frame(width: width * 0.8)
                
                
                
            }
            .frame(width: width, height: height)
            .background(
                Material.ultraThin
            )
            .onTapGesture {
                withAnimation{
                    DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(200), execute: {inspecting.toggle()})
                }
            }
            .opacity(inspecting ? 1 : 0)
            .animation(.easeIn, value: inspecting)
            .ignoresSafeArea()
            
        
    }
}


