//
//  PieDataPoint.swift
//  SwiftChartExample
//
//  Created by Volker Schmitt on 08.10.20.
//  Copyright © 2020 Volker Schmitt. All rights reserved.
//


import SwiftUI


struct PieDataPoint: Identifiable {
    let id: Int
    let value: Double
    let color: Color

    init(value: Double, color: Color) {
        self.id = Int.random(in: 1..<Int.max)
        self.value = value
        self.color = color
    }

    init(id: Int, value: Double, color: Color) {
        self.id = id
        self.value = value
        self.color = color
    }
}
