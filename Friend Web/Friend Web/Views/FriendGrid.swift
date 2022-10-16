//
//  FriendGrid.swift
//  Friend Web
//
//  Created by Victor Garcia on 10/15/22.
//

import SwiftUI

struct FriendGrid: View {
    
    @State var numFriends = 100
    @State var nodeList = [Node]()
    @State var circleSize : CGFloat = 0.0
    
    var body: some View {
        
        ForEach(createGrid(numFriends: numFriends)){i in
            Circle()
                .fill(.blue)
                .offset(x: CGFloat(i.x), y: CGFloat(i.y))
                .frame(width: CGFloat(circleSize))
        }
        .onAppear{
            nodeList = createGrid(numFriends: numFriends)
            circleSize = CGFloat(nodeList[1].x - nodeList[0].x) * 0.8
        }
        
        
    }
    
    func createGrid(numFriends : Int )->[Node]{
        var result = [Node]()
        let height = Int(UIScreen.main.bounds.height)
        let width = Int(UIScreen.main.bounds.width)
        var yPos = 12
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


struct Node : Identifiable {
    var id = UUID()
    var x : Float
    var y : Float
}


