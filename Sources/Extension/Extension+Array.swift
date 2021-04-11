//
//  Extension+Array.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 10.04.21.
//  Copyright © 2021 Volker Schmitt. All rights reserved.
//

import Foundation

extension Array where Element == BarDataPoint {
    /// Sort Array of BarDataPoint
    /// - Parameter sortedBy: SortingOptions
    /// - Returns: [BarDataPoint]
    func customSort(by sortedBy: SortingOptions) -> [BarDataPoint] {
        switch sortedBy {
            case .id:
                return self.sorted { $0.id < $1.id}
            case .valueAscending:
                return self.sorted { $0.value < $1.value}
            case .valueDescending:
                return self.sorted { $0.value > $1.value}
        }
    }
}
