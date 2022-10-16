//
//  ContentView.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/15/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var icvm = CloudKitUserViewModel()
    @State var userList = [UserModel]()
    
    var body: some View {
        
        ZStack{
            FriendGrid()
        }
        .onAppear{
            DispatchQueue.main.async {
                icvm.fetchItems()
                userList = icvm.userList
            }
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
