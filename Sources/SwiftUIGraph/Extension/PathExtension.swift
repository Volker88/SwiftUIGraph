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
    /// - Parameters:
    ///   - graphPoints: Array with points to generate the Graph
    ///   - graphWidth: Width of the Graph to evenly distribute the X-Axis
    ///   - graphHeight: Graph Height
    ///
    /// - Returns: Path
    ///
    static func drawPath(graphPoints: [Double], graphWidth: Double, graphHeight: Double) -> Path {
        var path = Path()
        
        // Graph Offset
        var offset = 0.0
        if graphPoints.min()! > 0.0 {
            offset = -graphPoints.min()!
        } else if graphPoints.min()! < 0.0 {
            offset = abs(graphPoints.min()!)
        } else {
            offset = 0.0
        }
        
        // Draw Graph
        var p1 = CGPoint(x: 5, y: graphPoints[0] + offset)
        path.move(to: p1)
        
        for pointIndex in 1..<graphPoints.count {
            let x = Double(pointIndex) * graphWidth / Double(graphPoints.count)
            let p2 = CGPoint(x: x, y: graphPoints[pointIndex] + offset)
            path.addLine(to: p2)
            p1 = p2
        }
        return path
    }
}
