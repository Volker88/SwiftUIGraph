//
//  LineGraph.swift
//  SwiftUIChart
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
    
    
    // MARK: - Initializer
    init(lineGraphSettings: LineGraphSettings) {
        self.lineGraphSettings = lineGraphSettings
    }
    
    
    // MARK: - Define Constants / Variables
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
        let dataArray = _array
        let maxGraphHeight = lineGraphSettings.graphHeight
        
        let dataArrayMaxValue = dataArray.map(abs).max() ?? 10
        
        self.minValue = dataArrayMaxValue * (-1)
        self.maxValue = dataArrayMaxValue
        
        print("Abs. Max. \(dataArrayMaxValue)")
        print("Min. \(minValue)")
        print("Max. \(maxValue)")
        let scaleFactor = maxGraphHeight / dataArrayMaxValue
        
        let ar = dataArray.map() { ($0 * scaleFactor / 2).rounded(toPlaces: lineGraphSettings.decimalDigits) }
        
        return (ar)
    }
}

