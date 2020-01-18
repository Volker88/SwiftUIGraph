//
//  LineGraph.swift
//  Sensor-App
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Class Definition
class LineGraph {
    
    // Calculate array to fit in graph
    func calculateArray(_array: [Double], _maxGraphHeight: Double) -> [Double] {
        let dataArray = _array
        let maxGraphHeight = _maxGraphHeight
        
        let dataArrayMaxValue = dataArray.map(abs).max() ?? 10

        
        let minValue = dataArrayMaxValue * (-1)
        let maxValue = dataArrayMaxValue
        
        print("Abs. Max. \(dataArrayMaxValue)")
        print("Min. \(minValue)")
        print("Max. \(maxValue)")
        let scaleFactor = maxGraphHeight / dataArrayMaxValue
        
        let ar = dataArray.map() { ($0 * scaleFactor / 2) }
        
        return (ar)
    }
}

