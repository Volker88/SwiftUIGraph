//
//  BarGraphView.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 09.04.21.
//  Copyright © 2021 Volker Schmitt. All rights reserved.
//

import SwiftUI

/// BarGraph View
///
/// Implement this View to show a Bar Graph
/// - Note: **horizontalLines** is optional. Default is 10 lines.
///         **sortedBy** is optional. Default is sorted by Id.
/// - Requires: [BarDataPoint]
public struct BarGraphView: View {
    let dataPoints: [BarDataPoint]
    let horizontalLines: Int
    private let maxValue: Double

    public init(
        dataPoints: [BarDataPoint],
        horizontalLines: Int = 10,
        sortedBy: SortingOptions? = nil
    ) {
        if let sorted = sortedBy {
            // Sorting option defined. Sorting will be applied
            self.dataPoints = dataPoints.customSort(by: sorted)
        } else {
            // No sorting option defined. The array will not be sorted
            self.dataPoints = dataPoints
        }

        self.horizontalLines = horizontalLines

        let highestPoint = dataPoints.max { $0.value < $1.value }
        maxValue = highestPoint?.value ?? 1
    }

    public var body: some View {
        ZStack {
            VStack {
                ForEach(1...horizontalLines, id: \.self) { _ in
                    Divider()
                    Spacer()
                }
            }
            HStack {
                VStack {
                    ForEach((1...horizontalLines).reversed(), id: \.self) { index in
                        let value = Int(maxValue / Double(horizontalLines) * Double(index))
                        Text("\(value)")
                            .lineLimit(1)
                            .font(.caption)
                            .padding(.horizontal)
                            .animation(nil)

                        Spacer()
                    }
                }
                .frame(width: 70)

                ForEach(dataPoints, id: \.self) { data in
                    VStack {
                        Rectangle()
                            .fill(data.color)
                            .scaleEffect(y: CGFloat(data.value / maxValue), anchor: .bottom)

                        Text(data.title)
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

struct BarChartView_Previews: PreviewProvider {
    static var dataPoints: [BarDataPoint] {
        var data = [BarDataPoint]()
        for index in 1..<Int.random(in: 3...10) {
            let value = Double.random(in: 0...1000).rounded(toPlaces: 2)
            data.append(
                BarDataPoint(
                    id: index,
                    value: value,
                    color: Color(
                        red: .random(in: 0...1),
                        green: .random(in: 0...1),
                        blue: .random(in: 0...1)
                    ),
                    title: "\(value)"
                )
            )
        }
        return data
    }

    static var previews: some View {
        ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
            BarGraphView(dataPoints: dataPoints, horizontalLines: 10)
                .colorScheme(scheme)
        }
    }
}
