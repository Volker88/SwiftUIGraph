//
//  PieGraphView.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 08.10.20.
//  Copyright © 2020 Volker Schmitt. All rights reserved.
//

import SwiftUI

///  PieGraph View
///
///   Implement this View to show a Pie Graph
/// - Note: **lineWidth** is optional. Define **lineWidth** to get a Donut Graph.
/// - Requires: [PieDataPoint]
public struct PieGraphView: View {

    let segments: [PieSegment]
    let lineWidth: Double?
    let dataArray: [PieDataPoint]

    public init(dataArray: [PieDataPoint], lineWidth: Double? = nil) {
        self.lineWidth = lineWidth
        self.dataArray = dataArray

        var segments = [PieSegment]()
        let total = dataArray.reduce(0) { $0 + $1.value }
        var startAngle = -Double.pi / 2

        for data in dataArray {
            let amount = .pi * 2 * (data.value / total)
            let segment = PieSegment(data: data, startAngle: startAngle, amount: amount)
            segments.append(segment)
            startAngle += amount
        }

        self.segments = segments
    }

    @ViewBuilder
    var mask: some View {
        if let lineWidth = lineWidth {
            Circle().strokeBorder(Color.white, lineWidth: CGFloat(lineWidth))
        } else {
            Circle()
        }
    }

    public var body: some View {
        HStack {
            ZStack {
                ForEach(segments) { segment in
                    segment
                        .fill(segment.data.color)
                }
            }
            .mask(mask)

            VStack(alignment: .leading) {
                ForEach(dataArray, id: \.self) { item in
                    HStack(alignment: .center) {
                        RoundedRectangle(cornerRadius: 3, style: .continuous)
                            .frame(width: 10, height: 10)
                            .foregroundColor(item.color)
                        Text("\(item.value, specifier: "%.2f") \(item.valueType)")
                    }
                }

            }.animation(nil)
        }
    }
}

struct PieGraphView_Previews: PreviewProvider {
    static var dataPoints: [PieDataPoint] {
        var data = [PieDataPoint]()
        for index in 1..<Int.random(in: 1...5) {
            let value = Double.random(in: 0...100).rounded(toPlaces: 2)
            data.append(
                PieDataPoint(
                    id: index,
                    value: value,
                    valueType: "€",
                    color: Color(
                        red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1)
                    )
                )
            )
        }
        return data
    }

    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            VStack {
                PieGraphView(dataArray: dataPoints)
                PieGraphView(dataArray: dataPoints, lineWidth: 20)
            }
            .colorScheme(scheme)
        }
    }
}
