//
//  animatedBG.swift
//  Friend Web
//
//  Created by Luis Bravo on 10/16/22.
//

import SwiftUI

struct animatedBG: View {
    var widthOfScreen = UIScreen.main.bounds.width
    var heightOfScreen = UIScreen.main.bounds.height
    @State var degrees = 0.0
    @State var animation = false
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            ForEach(1..<120){_  in
                MovingStars()
                    .onAppear{animation = true}
            }
        }
        .rotationEffect(Angle(degrees: animation ? 360.0 : 0))
        .animation(.linear.speed(0.001).repeatForever(), value: animation)
        
        //.saturation(animation ? 0.5 : 1)
    }
}

private struct MovingStars: View {
    @State var animating = false
    var x = CGFloat.random(in: -UIScreen.main.bounds.height / 2 ... UIScreen.main.bounds.height / 2)
    var y = CGFloat.random(in: -UIScreen.main.bounds.height / 2 ... UIScreen.main.bounds.height / 2)
    var starSize : CGFloat = CGFloat([5.0,8.0,10.0].randomElement()!)
    var timing = [1.0,1.1,1.2,1.3,1.4,1.5, 1.6,1.7,1.8,1.9,20].randomElement()!
    var color = [Color.orange,Color.yellow, Color.red, Color.blue, Color.pink, Color.purple, Color.cyan, Color.green].randomElement()
    var bright = [0.3,0.4,0.5,0.6,0.7,0.8].randomElement()!
    var body: some View {
        
        ZStack {
            Circle()
                .frame(width: starSize)
                .foregroundColor(color)
                .blur(radius: 0.5)
                .offset(x: x, y: y)
                .animation(.linear(duration: 100).speed(0.05).repeatForever(), value: animating)
                .saturation(bright)
                .opacity(animating ? 0.8 : 0.6)
                .animation(.linear(duration: bright).repeatForever(), value: animating)
        }
        .onAppear{
            animating = true
        }
    
    }
    
}
