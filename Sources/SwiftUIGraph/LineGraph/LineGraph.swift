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
    @Published var minValue : Double = -10
    @Published var maxValue : Double = 10
    
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
    /// - Parameter _array: [Double]
    ///
    /// - Returns: transformed [Double] array
    ///
    func calculateArray(_array: [Double]) -> [Double] {
        let inputArray = _array
        
        let inputArrayMaxValue = inputArray.map(abs).max() ?? 10
        
        self.minValue = inputArrayMaxValue * (-1)
        self.maxValue = inputArrayMaxValue
        
        print("Abs. Max. \(inputArrayMaxValue)")
        print("Min. \(minValue)")
        print("Max. \(maxValue)")
        let scaleFactor = graphHeight / inputArrayMaxValue
        
        let outputArray = inputArray.map() { ($0 * scaleFactor / 2).rounded(toPlaces: lineGraphSettings.decimalDigits) }
        
        return (outputArray)
    }
}

