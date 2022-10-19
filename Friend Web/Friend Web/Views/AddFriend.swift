//
//  AddFriend.swift
//  Friend Web
//
//  Created by Victor Garcia on 10/19/22.
//

import SwiftUI
import Foundation

struct AddFriend: View {
    var widthOfScreen = UIScreen.main.bounds.width
    var heightOfScreen = UIScreen.main.bounds.height
    
    var body: some View {
        
        VStack{
            
            ZStack {
                
                Button(action: {}){
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: widthOfScreen/1.5, height: heightOfScreen/15)
                }
                .foregroundColor(.cyan)
                
                Text("Add Friend")
                    .foregroundColor(.white)
                    .font(.system(size: heightOfScreen / 30, weight: .bold))
            }
            .shadow(radius: 10)
            
            
        }
        .padding(.top, heightOfScreen * 0.8)
    }
}



struct AddFriend_Previews: PreviewProvider {
    static var previews: some View {
        AddFriend()
    }
}
