import SwiftUI
import Foundation

struct GravityNodes: View {
    @State var screenHeight = UIScreen.main.bounds.height
    @State var screenWidth = UIScreen.main.bounds.width
    @State var Friends = [Node]()
    @State var Friends2 = [Node]()
    var body: some View {
        ZStack{
            Node(posCharge: false, Pos: CGPoint(x: 0, y: 0),nodeColor: Color.gray)
            ForEach(Friends2){i in 
                i
            }
            ForEach(Friends){i in 
                i
            }
            
        }
        .onAppear{
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
//                withAnimation{
            appeared()
//                    
//                }
//            })
            
        }
    }
    
    func appeared(){
        Friends.append(Node(posCharge: false, Pos: CGPoint(x: 0, y: 0),nodeColor: Color.gray))
        
        for i in 1...50{
            var nodePos =  CGPoint(x: CGFloat.random(in: -screenWidth/2...screenWidth/2), y: CGFloat.random(in: -screenHeight/2...screenHeight/2))
            Friends.append(Node(Pos: nodePos))
            Friends2.append(Node(Pos: nodePos, nodeColor: .gray))
            if(Friends[0].posCharge != Friends[i].posCharge){
                var dist = pow((Friends[0].Pos.x - Friends[i].Pos.x), 2) + pow((Friends[0].Pos.y - Friends[i].Pos.y), 2) 
                
                print("distance" + "\(dist)")
                var acc = 0.001 * (dist)
                print("this is acc: \(acc)")
                var newX = Friends[i].Pos.x
                var newY = Friends[i].Pos.y
                if(Friends[i].Pos.x < Friends[0].Pos.x){
                    newX = Friends[i].Pos.x + acc
                }
                else{
                    newX = Friends[i].Pos.x - acc
                }
                if(Friends[i].Pos.y < Friends[0].Pos.y){
                    newY = Friends[i].Pos.y + acc
                }
                else{
                    newY = Friends[i].Pos.y - acc
                }
                Friends[i] = Node(posCharge: true, acc: Int(acc), Pos: CGPoint(x: newX, y: newY),nodeColor: .blue)
                //print("acc" + "\(n2.acc)")
            }
            if(Friends[0].posCharge == Friends[i].posCharge){
                var dist = pow((Friends[0].Pos.x - Friends[i].Pos.x), 2) + pow((Friends[0].Pos.y - Friends[i].Pos.y), 2) 
                //print("distance" + "\(dist)")
                var acc = 10000 / sqrt(dist)
                var newX = Friends[i].Pos.x
                var newY = Friends[i].Pos.y
                if(Friends[i].Pos.x < Friends[0].Pos.x){
                    newX = Friends[i].Pos.x - acc
                }
                else{
                    newX = Friends[i].Pos.x + acc
                }
                if(Friends[i].Pos.y < Friends[0].Pos.y){
                    newY = Friends[i].Pos.y - acc
                }
                else{
                    newY = Friends[i].Pos.y + acc
                }
                Friends[i] = Node(posCharge: false, acc: Int(acc), Pos: CGPoint(x: newX, y: newY),nodeColor: .red)
                //print("acc" + "\(n2.acc)")
            }
            //                GravitationalForce(Node: Friends[0], Node: Friends[i])
        }
    }
}





struct Node : View, Identifiable{
    var id = UUID()
    var screenHeight = UIScreen.main.bounds.height
    var screenWidth = UIScreen.main.bounds.width
    //true is positive false is negative
    var posCharge : Bool? = Bool.random()
    var acc: Int? = 0
    var weigth = 0.001
    @State var Pos : CGPoint
    @State var nodeColor: Color? = Color.white
    var randomFloat = [0.1,0.2,0.3,0.4,0.5,0.6, 0.7, 0.8]
    var randomColor = [Color.red, Color.blue, Color.yellow, Color.orange, Color.purple]
    @State var animation = false
    
    var body: some View{
        
        Circle()
            .fill(nodeColor ?? .white)
            .frame(width: 50, height: 50, alignment: .center)
            .scaleEffect(animation ? 1 : 0)
            .offset(x:Pos.x, y:Pos.y)
            .animation(.spring().delay(randomFloat.randomElement()!).speed(0.5), value: animation)
            .onAppear{
                animation = true
                if(nodeColor == Color.white){
                    nodeColor = randomColor.randomElement()!
                }
                
            }
    
    if(posCharge ?? true){
        Text("+" )
            .offset(x:Pos.x, y:Pos.y)
    }
    else{
        Text("-" + "\(acc)")
            .offset(x:Pos.x, y:Pos.y)
    }
    }
}

