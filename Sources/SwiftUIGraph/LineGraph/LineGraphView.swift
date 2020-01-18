//
//  SwiftUIView.swift
//  SwiftUIChart
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Public Struct
public struct LineGraphView: View {
    
    // MARK: - Observed / @State Variables
    @ObservedObject var lineGraph : LineGraph
    @State private var minValue : Double = -10
    @State private var maxValue : Double = 10
    @State private var transformedArray : [Double] = [0]
    
    
    // MARK: - Declare Private Variables
    private var lineGraphSettings: LineGraphSettings

    
    // MARK: - Public Initializer
    public init(lineGraphPointsArray: [Double], lineGraphSettings: LineGraphSettings) {
        self.lineGraphSettings = lineGraphSettings
        lineGraph = LineGraph(lineGraphSettings: lineGraphSettings)
        self.lineGraph.lineGraphPointsArray = lineGraphPointsArray
    }
    
    
    // MARK: - Public Body
    public var body: some View {
        
        // MARK: - Return
        return HStack(spacing: 3) {
                VStack {
                    Group {
                        Text("\(lineGraph.maxValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                        Spacer()
                        Text("0")
                        Spacer()
                        Text("\(lineGraph.minValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                    }
                    .font(.caption)
                }
                .frame(width: CGFloat(70), height: CGFloat(lineGraphSettings.graphHeight), alignment: .trailing)
                
                VStack {
                    ZStack {
                        Rectangle()
                            .frame(width: CGFloat(lineGraphSettings.graphWidth) - 70, height: 0.5, alignment: .center)
                        
                        Path.drawPath(graphPoints: lineGraph.transformedArray, graphWidth: lineGraphSettings.graphWidth - 75)
                            .trim(from: 0, to: 1)
                            .stroke(LinearGradient(gradient: Gradient(colors: lineGraphSettings.lineColor), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: lineGraphSettings.lineWidth))
                            .rotationEffect(.degrees(180), anchor: .center)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                            .animation(.easeOut(duration: 1.2))
                            .drawingGroup()
                    }
                }
                .frame(height: CGFloat(lineGraphSettings.graphHeight))
                .border(lineGraphSettings.borderColor, width: lineGraphSettings.borderWidth)
            }
        .frame(width: CGFloat(lineGraphSettings.graphWidth), height: CGFloat(lineGraphSettings.graphHeight), alignment: .center)
    }
}


// MARK: - Preview
struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            NavigationView {
                LineGraphView(lineGraphPointsArray: [-10,-9,-8,0,7,8,9,10], lineGraphSettings: LineGraphSettings(graphWidth: 350.0, graphHeight: 350.0, maxPoints: 10, decimalDigits: 3, lineWitdh: 1, lineColor: [.red, .green], borderColor: .black, borderWidth: 1))
                    .colorScheme(scheme)
                    .previewLayout(.sizeThatFits)
            }
        }
    }
}
