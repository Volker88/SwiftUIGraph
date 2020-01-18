//
//  PathExtension.swift
//  SwiftUIChart
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
    ///
    /// - Returns: **Path**
    ///
    static func drawPath(graphPoints: [Double], graphWidth: Double) -> Path {
        var path = Path()
        var p1 = CGPoint(x: 0, y: graphPoints[0] + graphPoints.min()! * (-1))
        path.move(to: p1)
        
        for pointIndex in 1..<graphPoints.count {
            let x = Double(pointIndex) * graphWidth / Double(graphPoints.count)
            let p2 = CGPoint(x: x, y: graphPoints[pointIndex] + graphPoints.min()! * (-1))
            path.addLine(to: p2)
            p1 = p2
        }
        return path
    }
}
