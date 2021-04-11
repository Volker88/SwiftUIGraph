//
//  LineGraphSettings.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 19.01.20.
//  Copyright © 2021 Volker Schmitt. All rights reserved.
//
// swiftlint:disable line_length

import SwiftUI

///    Protocol to add required variables for  LineGraph
///   **lineGraphSettings:** Graph Customization Settings
public protocol LineGraphProtocol {
    var lineGraphSettings: LineGraphSettings { get }
}

@available(*, deprecated, renamed: "LineGraphProtocol", message: "Protocol will be removed in 1.0.0 due to a typo")
public protocol LineGraphPotocol {
    var lineGraphSettings: LineGraphSettings { get }
}

/// LineGraphSettings Struct
///
/// Customize the appearance of the line graph
/// - `maxPoints`: Maximum items in the array. In case of dynamic graphs only las *n* values will be kept and shown on the graph
/// - `decimalDigits`: Limit Decimal digits to *n* digits
/// - `lineWidth`: Width of the graph line
/// - `lineColor`: Array of `[Color]` to use one or multiple colors to make the line more colorful
/// - `borderColor`: Color of the border around the graph
/// - `borderWidth`: Line width of the border around the graph
public struct LineGraphSettings {

    // MARK: - Constants / Variables
    let maxPoints: Int
    let decimalDigits: Int
    let lineWidth: CGFloat
    let lineColor: [Color]
    let textColor: Color

    // MARK: - Public Initializer
    public init(maxPoints: Int, decimalDigits: Int, lineWidth: CGFloat, lineColor: [Color], textColor: Color) {
        self.maxPoints = maxPoints
        self.decimalDigits = decimalDigits
        self.lineWidth = lineWidth
        self.lineColor = lineColor
        self.textColor = textColor
    }

    @available(*, deprecated, message: "Initializer will be removed in 1.0.0 due to a typo in lineWitdh variable") // swiftlint:disable:this line_length
    public init(maxPoints: Int, decimalDigits: Int, lineWitdh: CGFloat, lineColor: [Color], textColor: Color) {
        self.maxPoints = maxPoints
        self.decimalDigits = decimalDigits
        self.lineWidth = lineWitdh
        self.lineColor = lineColor
        self.textColor = textColor
    }
}
