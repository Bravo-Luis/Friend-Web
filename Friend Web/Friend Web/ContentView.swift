//
//  ContentView.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/15/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State var icvm = CloudKitUserViewModel()
    @State var userList = [UserModel]()
    var body: some View {
        VStack{
            ForEach(userList) { list in
                Text(list.username)
            }
            Text(icvm.userList.count.formatted())
            Text(icvm.isSignedInToiCloud.description)
            Text(icvm.error)
            Text(icvm.userName)
        }
        .onAppear{
            icvm.fetchItems()
            userList = icvm.userList
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
