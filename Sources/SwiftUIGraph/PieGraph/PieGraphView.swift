//
//  PieGraphView.swift
//  SwiftChartExample
//
//  Created by Volker Schmitt on 08.10.20.
//  Copyright © 2020 Volker Schmitt. All rights reserved.
//

import SwiftUI


struct PieGraphView: View {
    let pieSegments: [PieSegment]
    let strokeWidth: Double?
    
    init(dataPoints: [PieDataPoint], strokeWidth: Double? = nil) {
        self.strokeWidth = strokeWidth
        
        var segments = [PieSegment]()
        let total = dataPoints.reduce(0) { $0 + $1.value }
        var startAngle = -Double.pi / 2
        
        for data in dataPoints {
            let amount = .pi * 2 * (data.value / total)
            let segment = PieSegment(data: data, startAngle: startAngle, amount: amount)
            segments.append(segment)
            startAngle += amount
        }
        
        pieSegments = segments
    }
    
    
    @ViewBuilder
    var mask: some View {
        if let strokeWidth = strokeWidth {
            Circle().strokeBorder(Color.white, lineWidth: CGFloat(strokeWidth))
        } else {
            Circle()
        }
    }
    
    var body: some View {
        ZStack {
            ForEach(pieSegments) { segment in
                segment
                    .fill(segment.data.color)
            }
        }
        .mask(mask)
    }
}
