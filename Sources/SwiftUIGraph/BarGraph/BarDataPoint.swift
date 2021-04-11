//
//  BarDataPoint.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 09.04.21.
//  Copyright © 2021 Volker Schmitt. All rights reserved.
//

import SwiftUI

/// BarDataPoint
///
/// Used to provide the DataPoints to the BarGraph
public struct BarDataPoint: Identifiable, Hashable {
    public let id: Int
    public let value: Double
    public let color: Color
    public let title: String

    /// ID will be generated randomly
    /// - Parameters:
    ///   - value: Double
    ///   - color: Color
    ///   - title: Title
    public init(value: Double, color: Color, title: String = "") {
        self.id = Int.random(in: 1..<Int.max)
        self.value = value
        self.color = color
        self.title = title
    }

    /// ID can be be passed in for custom sorting
    /// - Parameters:
    ///   - id: Int
    ///   - value: Double
    ///   - color: Color
    ///   - title: Title
    public init(id: Int, value: Double, color: Color, title: String = "") {
        self.id = id
        self.value = value
        self.color = color
        self.title = title
    }
}
