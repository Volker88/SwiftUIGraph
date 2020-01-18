//
//  SwiftUIView.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Public Struct
public struct LineGraphView: View {
    
    let lineGraph = LineGraph()
    
    
    // MARK: - Declare Private Variables
    private var maxGraphWidth : Double
    private var maxGraphHeight : Double
    private var maxPoints : Int
    private var array = [Double]()
    
    // MARK: - Public Initializer
    public init(_array: [Double], _maxGraphWidth: Double, _maxGraphHeight: Double, _maxPoints: Int) {
        array = _array
        maxGraphWidth = _maxGraphWidth
        maxGraphHeight = _maxGraphHeight
        maxPoints = _maxPoints
    }
    
    
    
    @State private var minValue : Double = -10
    @State private var maxValue : Double = 10
    @State private var transformedArray : [Double] = [0]
    @State var data : [Double] = [0,4,6,10,50,100,-20,-100,-200, 4, 6, 10, 50, 100, -20, -100, -200, -100] {
        mutating didSet {
            // Check for maximum elements in Array and remove first to keep the max
            defer {
                self.transformedArray = lineGraph.calculateArray(_array: data, _maxGraphHeight: maxGraphHeight)
                print("transformed \(transformedArray)")
            }
            
            if data.count > maxPoints {
                data.removeFirst()
                print("Removed item")
            }
        }
    }
    
    
    // Calculate array to fit in graph
    func calculateArray(array: [Double], _maxGraphHeight: Double) -> [Double] {
        let dataArray = array
        let maxGraphHeight = _maxGraphHeight
        
        //let dataArrayMaxValue = dataArray.map(abs).max() ?? 10 // Absolute Maximum
        guard let dataArrayMaxValue = dataArray.map(abs).max() else { return dataArray }
        
        
        self.minValue = dataArrayMaxValue * (-1)
        self.maxValue = dataArrayMaxValue
        
        print("Abs. Max. \(dataArrayMaxValue)")
        print("Min. \(self.minValue)")
        print("Max. \(self.maxValue)")
        let scaleFactor = maxGraphHeight / dataArrayMaxValue
        
        let ar = dataArray.map() { ($0 * scaleFactor / 2) }
        
        return ar
    }
    
    
    // MARK: - Debug to generate Array
    func generateArray() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (_) in
            let random = Double.random(in: -100...100).rounded(toPlaces: 1)
            
            self.data.append(random)
        }
    }
    
    
    
    public var body: some View {
        
        return HStack(spacing: 0) {
            VStack {
                Group {
                    Text("\(self.maxValue, specifier: "%.5f")")
                    Spacer()
                    Text("0")
                    Spacer()
                    Text("\(self.minValue, specifier: "%.5f")")
                }
                .font(.caption)
            }
            .frame(width: CGFloat(75), height: CGFloat(maxGraphHeight), alignment: .trailing)
            //.border(Color(.red), width: 1)
            
            VStack {
                ZStack {
                    
                    Rectangle()
                        .frame(width: CGFloat(maxGraphWidth) - 75, height: 0.5, alignment: .center)
                    
                    Path.drawPath(graphPoints: self.transformedArray, graphWidth: maxGraphWidth - 75)
                        .trim(from: 0, to: 1)
                        .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading, endPoint: .trailing) ,style: StrokeStyle(lineWidth: 3))
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 1.2))
                        .drawingGroup()
                    
                }
            }
            .frame(height: CGFloat(maxGraphHeight))
            .border(Color("StandardTextColor"), width: 1)
            
        }
        .frame(width: CGFloat(maxGraphWidth), height: CGFloat(maxGraphHeight), alignment: .center)
        .onAppear(perform: generateArray)
    }
}


// MARK: - Preview
struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            NavigationView {
                LineGraphView(_array: [-10,-9,-8,0,7,8,9,10],_maxGraphWidth: 350, _maxGraphHeight: 300, _maxPoints: 25)
                    .colorScheme(scheme)
                    .previewLayout(.sizeThatFits)
            }
        }
    }
}



