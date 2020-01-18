//
//  DoubleExtenstionTests.swift
//  SwiftUIChart
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import XCTest
import SwiftUI
@testable import SwiftUIGraph


// MARK: - Final Class
final class DoubleExtenstionTests: XCTestCase {
    
    func testDoubleExtensionRoundUp() {
        //given
        let number = 100.000005
        let decimalDigits = 5
        
        //when
        let rounded = number.rounded(toPlaces: decimalDigits)
        
        //then
        XCTAssertEqual(rounded, 100.00001, "Rounded \(number) to \(rounded) does not equal 100.00001")
    }
    
    func testDoubleExtensionRoundDown() {
        //given
        let number = 100.111114
        let decimalDigits = 5
        
        //when
        let rounded = number.rounded(toPlaces: decimalDigits)
        
        //then
        XCTAssertEqual(rounded, 100.11111, "Rounded \(number) to \(rounded) does not equal 100.11111")
    }
}
