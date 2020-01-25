//
//  LineGraphSettings.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 19.01.20.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import Foundation
import SwiftUI


//MARK: - Public Protocol
///
///    Protocol to add required variables for  LineGraph
///
///   **lineGraphSettings:** Graph Customization Settings
///
public protocol LineGraphPotocol {
    var lineGraphSettings: LineGraphSettings { get }
}


// MARK: - Public Struct
/// LineGraphSettings Struct
///
/// Customize the appearance of the line graph
///
/// - `maxPoints`: Maximum items in the array. In case of dynamic graphs only las *n* values will be kept and shown on the graph
/// - `decimalDigits`: Limit Decimal digits to *n* digits
/// - `lineWidth`: Width of the graph line
/// - `lineColor`: Array of `[Color]` to use one or multiple colors to make the line more colorful
/// - `borderColor`: Color of the border around the graph
/// - `borderWidth`: Line width of the border around the graph
///
public struct LineGraphSettings {
    
    // MARK: - Constants / letiables
    let maxPoints: Int
    let decimalDigits: Int
    let lineWidth: CGFloat
    let lineColor: [Color]
    let textColor: Color
    
    
    // MARK: - Public Initializer
    public init(maxPoints: Int, decimalDigits: Int, lineWitdh: CGFloat, lineColor: [Color], textColor: Color) {
        self.maxPoints = maxPoints
        self.decimalDigits = decimalDigits
        self.lineWidth = lineWitdh
        self.lineColor = lineColor
        self.textColor = textColor
    }
}
