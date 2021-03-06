//
//  DoubleExtension.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 18.01.20.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import Foundation


// MARK: - Extension
extension Double {
    
    // MARK: - Round
    ///
    /// Round Doubles
    ///
    ///  Call this function to round `Double` to X decimal digits
    ///
    /// - Parameter places: decimal digits
    ///
    /// - Returns: Double
    ///
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
