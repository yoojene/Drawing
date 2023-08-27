//
//  ContentView.swift
//  Drawing
//
//  Created by Eugene on 26/08/2023.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5),
                        ]),
                           startPoint: .top,
                           endPoint: .bottom
                        ),
//                        color(for: value, brightness: 1),
                        lineWidth: 2)
            }
        }
        .drawingGroup() //
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        
        }
        
        return  Color(hue: targetHue, saturation: 1, brightness: brightness)
        
    }
}


struct Arrow: Shape {

    
    // I struggled with the rect.minX, rect.maxY relative to the shapes rect hence set to abs values
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 200, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.addLine(to: CGPoint(x: 300, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 100))
        path.closeSubpath()
        path.move(to: CGPoint(x: 200, y: 300))
        path.addLine(to: CGPoint(x: 200, y: 603) )


        return path

    }
}

struct ContentView: View {
    
    @State private var thickness = 10.0
    @State private var colors = 0.01
    var body: some View {
    
        ZStack {
            ColorCyclingRectangle(amount: colors, steps: 100)

            VStack {
                Arrow()
                    .stroke(.black, style: StrokeStyle(lineWidth: thickness))
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
                
                Slider(value: $colors, in: 0.1...0.9, step: 0.01)
                .padding()
                
            }
               
        }
        .ignoresSafeArea()
 
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
