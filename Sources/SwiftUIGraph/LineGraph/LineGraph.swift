//
//  LineGraph.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Class Definition
class LineGraph: ObservableObject {
    
    // MARK: - Published Variables
    @Published var transformedArray: [Double] = []
    @Published var maxValue : Double = 0
    @Published var upperQuarterValue : Double = 0
    @Published var midValue : Double = 0
    @Published var lowerQuarterValue : Double = 0
    @Published var minValue : Double = 0
    
    
    // MARK: - Constants / Variables
    let graphHeight: Double
    
    
    // MARK: - Initializer
    init(lineGraphSettings: LineGraphSettings, graphHeight: Double) {
        self.lineGraphSettings = lineGraphSettings
        self.graphHeight = graphHeight
    }
    
    
    // MARK: - Declare Constants / Variables
    let lineGraphSettings: LineGraphSettings
    var lineGraphPointsArray : [Double] = [] {
        didSet {
            var cleanArray = lineGraphPointsArray
            // Check for maximum elements in Array and limites it to specified quantity of items
            defer {
                transformedArray = calculateArray(_array: cleanArray)
                print("transformed \(transformedArray)")
            }
            if lineGraphPointsArray.count > lineGraphSettings.maxPoints {
                cleanArray = lineGraphPointsArray.suffix(lineGraphSettings.maxPoints)
            }
        }
    }
    
    
    //MARK: - Calculate Array
    ///   Calculate Array
    ///
    ///   Calculates the array based on the max. graph height to scale the graph
    ///
    /// - Parameter _array: `[Double]`
    ///
    /// - Returns: transformed `[Double]` Array
    ///
    func calculateArray(_array: [Double]) -> [Double] {
        let inputArray = _array
        
        self.maxValue = inputArray.max()!
        self.midValue = (inputArray.max()! + inputArray.min()!) / 2
        self.minValue = inputArray.min()!
        
        self.upperQuarterValue = (maxValue + midValue) / 2
        self.lowerQuarterValue = (midValue + minValue) / 2

        print("Min. \(minValue)")
        print("Mid. \(midValue)")
        print("Max. \(maxValue)")
        let scaleFactor = (graphHeight) / (maxValue - minValue)
        print("Scale: \(scaleFactor)")
        print("Input: \(inputArray)")
        
        let outputArray = inputArray.map() {
                ($0 * scaleFactor).rounded(toPlaces: lineGraphSettings.decimalDigits)
        }
        return (outputArray)
    }
}

