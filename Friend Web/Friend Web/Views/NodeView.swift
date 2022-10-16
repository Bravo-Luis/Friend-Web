//
//  NodeView.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/16/22.
//

import SwiftUI

struct NodeView: View {
    
    @State var user : UserModel
    @Binding var inspect : Bool
    @State var size : CGFloat
    @State var this = Node(x: 0.0, y: 0.0)
    @State var animation = false
    @Binding var focus : UserModel
    @Binding var availableList : [Node]
    var randomColor : [Color] = [Color.red, Color.blue, Color.brown, Color.green, Color.pink, Color.cyan, Color.orange, Color.yellow, Color.gray, Color.indigo, Color.purple, Color.mint, Color.teal]
    @Binding var forLines : [NodeForLine]
    var body: some View {
        ZStack{
            Circle()
                .fill(randomColor.randomElement()!)
            Text(user.username.first!.description)
                .font(.system(size: size, weight: .bold))
        }
        .ignoresSafeArea()
        .onTapGesture {
            focus = user
            inspect = true
        }
        .offset(x: CGFloat(this.x), y: CGFloat(this.y))
        .scaleEffect(animation ? 1 : 0.1)
        .animation(.spring(), value: animation)
        .onAppear{
            let randomNum = (0..<availableList.count).randomElement()!
            this = Node(x: availableList[randomNum].x, y: availableList[randomNum].y)
            availableList.remove(at: randomNum)
            
            forLines.append(NodeForLine(x: this.x, y: this.y, user: user))
            
            animation = true
        }
    }
}
