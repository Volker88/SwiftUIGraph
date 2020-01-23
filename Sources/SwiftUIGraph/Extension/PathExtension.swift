//
//  PathExtension.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 18.01.20.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import SwiftUI


// MARK: - Extension
extension Path {
    
    // MARK: - drawPath
    ///
    /// Draw Path
    ///
    ///  Call this function to draw the graph for an Array of Doubles
    ///
    ///  - Note:
    ///  **graphPoints**: Array to create the graph
    ///
    ///  **graphWidth**: specify the width of the graph
    ///
    /// - Parameters:
    ///   - graphPoints: [Double]
    ///   - graphWidth: Double
    ///   - graphHeight: Double
    ///
    /// - Returns: **Path**
    ///
    static func drawPath(graphPoints: [Double], graphWidth: Double, graphHeight: Double) -> Path {
        var path = Path()
        var p1 = CGPoint(x: 0, y: graphPoints[0] + (graphHeight / 2))
        path.move(to: p1)
        
        for pointIndex in 1..<graphPoints.count {
            let x = Double(pointIndex) * graphWidth / Double(graphPoints.count)
            let p2 = CGPoint(x: x, y: graphPoints[pointIndex] + (graphHeight / 2))
            path.addLine(to: p2)
            p1 = p2
        }
        return path
    }
}
