//
//  LineGraphTests.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


// MARK: - Import
import XCTest
import SwiftUI
@testable import SwiftUIGraph


// MARK: - Final Class
final class LineGraphTests: XCTestCase {
    
    func testLineGraphSettingsStruct() {
        //given
        
        //when
        let sut = LineGraphSettings(maxPoints: 50, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        
        //then
        XCTAssertNotNil(sut, "Struct can not be created!")
    }
    
    func testLineGraphArrayCalculation() {
        //given
        let lineGraphSettings = LineGraphSettings(maxPoints: 10, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 100)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //when
        let calculatedArray = sut.calculateArray(_array: array)
        
        //then
        XCTAssertEqual(calculatedArray, [-50.0, -25.0, -25.0, 0.0, 0.0, 25.0, 25.0, 50.0], "Calculation of Array failed")
        
    }
    
    func testLineGraphArrayMaxPoints() {
        //given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //when
        sut.lineGraphPointsArray = array
        
        //then
        XCTAssertEqual(sut.transformedArray.count, lineGraphSettings.maxPoints, "Limiting items in Array to \(lineGraphSettings.maxPoints) failed with \(sut.transformedArray.count) items in Array")
        
    }
    
    func testLineGraphView() {
        //given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //when
        let sut = LineGraphView(lineGraphPointsArray: array, lineGraphSettings: lineGraphSettings, graphWidth: 350, graphHeight: 350)
        
        //then
        XCTAssertNotNil(sut.body, "Body not found!")
    }
    
    func testLineGraphArrayMaxValue() {
        //given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 100]
        
        //when
        _ = sut.calculateArray(_array: array)
        
        //then
        XCTAssertEqual(sut.maxValue, 150, "Max. Value of the Array is wrong")
    }
    
    func testLineGraphArrayMinValue() {
        //given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]
        
        //when
        _ = sut.calculateArray(_array: array)
        
        //then
        XCTAssertEqual(sut.minValue, -200, "Min. Value of the Array is wrong")
    }
    
    func testPerformanceOfArrayTransformation() {
        //given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary, borderColor: .red, borderWidth: 1)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array = Array(stride(from: -1000.0, through: 1000.0, by: 0.1))
        
        //measure
        measure {
            _ = sut.calculateArray(_array: array)
        }
    
    }
}
