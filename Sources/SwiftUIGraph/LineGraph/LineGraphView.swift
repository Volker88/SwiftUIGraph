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
///   - **lineGraphPointsArray**: Double Array
///   - **lineGraphSettings**: Settings
///   - **graphWidth**: Graph Width
///   - **graphHeight**: Graph Height
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
                    Text("0")
                    Spacer()
                    Text("\(lineGraph.minValue, specifier: "%.\(lineGraphSettings.decimalDigits)f")")
                }
                .font(.caption)
                .foregroundColor(lineGraphSettings.textColor)
            }
            .frame(width: CGFloat(70), height: graphHeight, alignment: .trailing)
            
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: graphWidth - 70, height: 0.5, alignment: .center)
                    
                    Path.drawPath(graphPoints: lineGraph.transformedArray, graphWidth: Double(graphWidth) - 70, graphHeight: Double(graphHeight))
                        .trim(from: 0, to: 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: lineGraphSettings.lineColor), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: lineGraphSettings.lineWidth))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 1.2))
                        .drawingGroup()
                }
            }
            .frame(height: graphHeight)
            .border(lineGraphSettings.borderColor, width: lineGraphSettings.borderWidth)
        }
        .frame(width: graphWidth, height: graphHeight, alignment: .center)
    }
}


// MARK: - Preview
struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            LineGraphView(lineGraphPointsArray: [-10,-9,-8,0,7,8,9,10], lineGraphSettings: LineGraphSettings(maxPoints: 10, decimalDigits: 3, lineWitdh: 1, lineColor: [.red, .green], textColor: .primary, borderColor: .black, borderWidth: 1), graphWidth: 350, graphHeight: 350)
                .colorScheme(scheme)
                .previewLayout(.sizeThatFits)
        }
    }
}
