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
    
    //MARK: -  SetUp
    override func setUp() {
        
    }

    // MARK: - TearDown
    override func tearDown() {
        
    }
    
    
    // MARK: - General Tests
    func testLineGraphSettingsStruct() {
        //Given
        
        //When
        let sut = LineGraphSettings(maxPoints: 50, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        
        //Then
        XCTAssertNotNil(sut, "Struct can not be created!")
    }
 
    func testLineGraphView() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //When
        let sut = LineGraphView(lineGraphPointsArray: array, lineGraphSettings: lineGraphSettings, graphWidth: 350, graphHeight: 350)
        
        //Then
        XCTAssertNotNil(sut.body, "Body not found!")
    }
    
    
    // MARK: - Test Array min/mid/max and upper/lower quarter
    func testLineGraphArrayMaxValue() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 100]
        
        //When
        _ = sut.calculateArray(_array: array)
        
        //Then
        XCTAssertEqual(sut.maxValue, 100, "Max. Value of the Array is wrong")
    }
    
    func testLineGraphArrayMidValue() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]
        
        //When
        _ = sut.calculateArray(_array: array)
        
        //Then
        XCTAssertEqual(sut.midValue, 25, "Min. Value of the Array is wrong")
    }
    
    func testLineGraphArrayMinValue() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]
        
        //When
        _ = sut.calculateArray(_array: array)
        
        //Then
        XCTAssertEqual(sut.minValue, -150, "Min. Value of the Array is wrong")
    }
    
    func testLineGraphArrayUpperQuarterValue() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]
        
        //When
        _ = sut.calculateArray(_array: array)
        
        //Then
        XCTAssertEqual(sut.upperQuarterValue, 112.5, "Min. Value of the Array is wrong")
    }
    
    func testLineGraphArrayLowerQuarterValue() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]
        
        //When
        _ = sut.calculateArray(_array: array)
        
        //Then
        XCTAssertEqual(sut.lowerQuarterValue, -62.5, "Min. Value of the Array is wrong")
    }
    
    
    // MARK: - Array Transformation
    func testLineGraphArrayCalculation() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 10, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 100)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //When
        let calculatedArray = sut.calculateArray(_array: array)
        
        //Then
        XCTAssertEqual(calculatedArray, [-50.0, -25.0, -25.0, 0.0, 0.0, 25.0, 25.0, 50.0], "Calculation of Array failed")
    }
    
    func testLineGraphTransformation() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 10, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 100)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //When
        sut.lineGraphPointsArray = array
        
        //Then
        let result = [-50.0, -25.0, -25.0, 0.0, 0.0, 25.0, 25.0, 50.0]
        XCTAssertEqual(sut.transformedArray, result, "Transformation of array failed with Result: \(sut.transformedArray)")
    }
    
    func testLineGraphArrayMaxPoints() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array : [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]
        
        //When
        sut.lineGraphPointsArray = array
        
        //Then
        XCTAssertEqual(sut.transformedArray.count, lineGraphSettings.maxPoints, "Limiting items in Array to \(lineGraphSettings.maxPoints) failed with \(sut.transformedArray.count) items in Array")
    }
    
    
    // MARK: - Performance Tests
    func testPerformanceOfArrayTransformation() {
        //Given
        let lineGraphSettings = LineGraphSettings(maxPoints: 5, decimalDigits: 3, lineWitdh: 2, lineColor: [.red, .yellow, .green], textColor: .primary)
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array = Array(stride(from: -1000.0, through: 1000.0, by: 0.1))
        
        //Measure
        measure {
            _ = sut.calculateArray(_array: array)
        }
    
    }
}
