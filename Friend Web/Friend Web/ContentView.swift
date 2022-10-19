//
//  ContentView.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/15/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var icvm = CloudKitUserViewModel()
    @State var friendList = [UserModel]()
        
    
    var body: some View {
        
        ZStack{
            if icvm.username == "" {
                loginScreen(icvm: icvm)
            }else{
                
                ZStack{
                    //animatedBG()
                    HomeScreen(icvm: icvm)
                    
                    AddFriend()
                }
                

            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


