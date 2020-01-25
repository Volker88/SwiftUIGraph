//
//  SwiftUIView.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Public Struct
///
///  LineGraph View
///
///   Implement this view to show a line Graph
///
/// - Parameters:
///   - `lineGraphPointsArray`: Array to generate the Graph
///   - `lineGraphSettings`: Settings for Graph Customization
///   - `graphWidth`: Graph Width
///   - `graphHeight`: Graph Height
///
public struct LineGraphView: View {
    
    // MARK: - Observed / @State Variables
    @ObservedObject var lineGraph : LineGraph
    @State private var minValue : Double = -10
    @State private var maxValue : Double = 10
    @State private var transformedArray : [Double] = [0]
    
    
    // MARK: - Declare Private Variables
    private var lineGraphSettings: LineGraphSettings
    private var graphWidth: CGFloat
    private var graphHeight: CGFloat
    
    
    // MARK: - Public Initializer
    public init(lineGraphPointsArray: [Double], lineGraphSettings: LineGraphSettings, graphWidth: CGFloat, graphHeight: CGFloat) {
        self.lineGraphSettings = lineGraphSettings
        self.graphWidth = graphWidth
        self.graphHeight = graphHeight
        self.lineGraph = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: Double(graphHeight))
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
                    Text("\(lineGraph.upperQuarterValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                    Spacer()
                    Text("\(lineGraph.midValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                    Spacer()
                    Text("\(lineGraph.lowerQuarterValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                    Spacer()
                    Text("\(lineGraph.minValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                }
                .lineLimit(1)
                .font(.caption)
                .foregroundColor(lineGraphSettings.textColor)
            }
            .frame(width: 70, height: graphHeight, alignment: .trailing)
            
            VStack {
                ZStack {
                    VStack() {
                       Rectangle()
                        .frame(width: graphWidth - 90, height: 0.5, alignment: .center)
                        Spacer()
                        Rectangle()
                        .frame(width: graphWidth - 90, height: 0.5, alignment: .center)
                        Spacer()
                        Rectangle()
                        .frame(width: graphWidth - 90, height: 0.5, alignment: .center)
                        Spacer()
                        Rectangle()
                        .frame(width: graphWidth - 90, height: 0.5, alignment: .center)
                        Spacer()
                        Rectangle()
                        .frame(width: graphWidth - 90, height: 0.5, alignment: .center)
                    }
                    
                    Path.drawPath(graphPoints: lineGraph.transformedArray, graphWidth: Double(graphWidth) - 90, graphHeight: Double(graphHeight))
                        .trim(from: 0, to: 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: lineGraphSettings.lineColor), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: lineGraphSettings.lineWidth))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 1.2))
                        .drawingGroup()
                        .frame(alignment: .trailing)
                }
            }
            .frame(height: graphHeight)
            
            Spacer()
                .frame(width: 20)
            
        }
        .frame(width: graphWidth, height: graphHeight, alignment: .center)
    }
}


// MARK: - Preview
struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            LineGraphView(lineGraphPointsArray: [-10,-9,-8,0,7,8,9,10], lineGraphSettings: LineGraphSettings(maxPoints: 10, decimalDigits: 3, lineWitdh: 1, lineColor: [.red, .green], textColor: .primary), graphWidth: 350, graphHeight: 350)
                .colorScheme(scheme)
                .previewLayout(.sizeThatFits)
        }
    }
}
