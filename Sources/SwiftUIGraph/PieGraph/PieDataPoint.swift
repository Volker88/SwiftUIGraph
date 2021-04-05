//
//  PieDataPoint.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 08.10.20.
//  Copyright © 2020 Volker Schmitt. All rights reserved.
//

import SwiftUI

/// PieDataPoint
///
/// Used to provide the DataPoints to the PieGraph
public struct PieDataPoint: Identifiable, Hashable {

    public let id: Int
    public let value: Double
    public let valueType: String
    public let color: Color

    public  init(value: Double, valueType: String = "", color: Color) {
        self.id = Int.random(in: 1..<Int.max)
        self.value = value
        self.valueType = valueType
        self.color = color
    }

    public init(id: Int, value: Double, valueType: String = "", color: Color) {
        self.id = id
        self.value = value
        self.valueType = valueType
        self.color = color
    }
}
