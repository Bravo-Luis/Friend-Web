//
//  line.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/15/22.
//

import SwiftUI

struct line: View {
    @State var start : CGPoint
    @State var end : CGPoint
    
    @State var height = UIScreen.main.bounds.height
    @State var width = UIScreen.main.bounds.width
    
    @State var lineWidth = 10
    var body: some View {
        Path(){
            path in
            path.addLines([start, end])
            
        }
        .offset(y: -height / 2.2)
        .stroke(style: .init(lineWidth:CGFloat(lineWidth)))
        .opacity(0.5)
        .onAppear{
            start.x += width / 2
            start.y += height / 2
            
            end.x += width / 2
            end.y += height / 2
            
            
        }
        .offset(y: 5)
    }
        
}

struct line_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            
        }
    }
}
