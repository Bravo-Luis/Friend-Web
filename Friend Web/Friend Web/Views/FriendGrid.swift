//
//  FriendGrid.swift
//  Friend Web
//
//  Created by Victor Garcia on 10/15/22.
//

import SwiftUI

struct FriendGrid: View {
    
    @ObservedObject var icvm = CloudKitUserViewModel()
    @State var numFriends = 0
    @State var nodeList = [Node]()
    @State var circleSize : CGFloat = 0.0
    @Binding var inspecting : Bool
    @Binding var focus : UserModel
    @State var lineList = [LinePoints]()
    @State var forLines = [NodeForLine]()
    
    var body: some View {
        
        ZStack{
            ForEach(icvm.fetchFriends()){i in
                
                NodeView(user: i, inspect: $inspecting, size: circleSize, focus: $focus, availableList: $nodeList, forLines: $forLines)
                    .frame(width: circleSize)
                    .ignoresSafeArea()
                    
            }.zIndex(-1)
            
            ForEach(lineList) { lin in
                line(start: CGPoint(x: CGFloat(lin.startx), y: CGFloat(lin.starty)), end: CGPoint(x: CGFloat(lin.endx), y: CGFloat(lin.endy)))
            }.zIndex(-1)
            
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 10, alignment: .bottom)
        .onAppear{
            numFriends = icvm.fetchFriends().count
            nodeList = createGrid(numFriends: icvm.fetchFriends().count)
            circleSize = CGFloat(nodeList[1].x - nodeList[0].x) * 0.8
        }
        .onChange(of: forLines, perform: {i in
            for j in i {
                for k in i {
                    if k != j {
                        if j.user.friendsList.contains(k.user.username){
                            lineList.append(LinePoints(startx: j.x, starty: j.y, endx: k.x, endy: k.y))
                        }
                    }
                }
            }
            
            
            
        })
        
        
    }
    
    
    
    func createGrid(numFriends : Int )->[Node]{
        var result = [Node]()
        let height = Int(UIScreen.main.bounds.height - UIScreen.main.bounds.height / 6)
        let width = Int(UIScreen.main.bounds.width)
        var yPos = 8
        var xPos = 6
        
        let area = yPos * xPos

        if(area < numFriends){
            
        yPos = yPos * numFriends / area
        xPos = xPos * numFriends / area
            
        }
        
        
        for i in 0..<yPos {
            for j in 0..<xPos {
                
                if i != 0 && i != yPos - 1 {
                    
                    var w = j * width / xPos - width + (j + 1) * (width / xPos)
                    var h = i * height / yPos - height + (i + 1) * (height / yPos)
                    
                    w = w / 2
                    h = h / 2
                    
                    result.append(Node(x: Float(w), y: Float(h)))
                }
                
            }
        }
        
        return result
    }
    
}


struct Node : Identifiable, Equatable{
    var id = UUID()
    var x : Float
    var y : Float
}

struct NodeForLine : Identifiable, Equatable {
    var id = UUID()
    var x : Float
    var y : Float
    var user : UserModel
}


struct LinePoints : Identifiable{
    
    var id = UUID()
    
    var startx : Float
    var starty : Float
    var endx : Float
    var endy : Float
    
}
