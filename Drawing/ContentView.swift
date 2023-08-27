//
//  ContentView.swift
//  Drawing
//
//  Created by Eugene on 26/08/2023.
//

import SwiftUI

struct Arrow: Shape {

    
    // I struggled with the rect.minX, rect.maxY relative to the shapes rect
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.addLine(to: CGPoint(x: 300, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 100))
//        path.fill(.blue)
        path.closeSubpath()
        path.move(to: CGPoint(x: 200, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 603) )


        return path

    }
}

struct ContentView: View {
    
    @State private var thickness: CGFloat = 10.0
    var body: some View {
    
        VStack {
            Arrow()
                .stroke(.blue, style: StrokeStyle(lineWidth: thickness))
                .onTapGesture {
                    withAnimation(.easeIn(duration: 1)) {
                        thickness =  Double.random(in: 10...100.0)
                    }
                   
                }
            
            Slider(value: $thickness, in: 1...100.0, onEditingChanged: { value in
                withAnimation {
                    print("slider edit \(thickness)")
                }
            })
            .padding()
            
        }
            
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
