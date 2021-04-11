//
//  LineGraphTests.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2021 Volker Schmitt. All rights reserved.
//

import XCTest

@testable import SwiftUIGraph

final class LineGraphTests: XCTestCase {

    let lineGraphSettings = LineGraphSettings(
        maxPoints: 5,
        decimalDigits: 3,
        lineWidth: 2,
        lineColor: [.red, .yellow, .green],
        textColor: .primary
    )

    let lineGraphSettings2 = LineGraphSettings(
        maxPoints: 10,
        decimalDigits: 3,
        lineWidth: 2,
        lineColor: [.red, .yellow, .green],
        textColor: .primary
    )

    func testLineGraphSettingsStruct() throws {
        //Given

        //When
        let sut = LineGraphSettings(
            maxPoints: 50,
            decimalDigits: 3,
            lineWidth: 2,
            lineColor: [.red, .yellow, .green],
            textColor: .primary
        )

        //Then
        XCTAssertNotNil(sut, "Struct can not be created!")
    }

    func testLineGraphView() throws {
        //Given

        let array: [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]

        //When
        let sut = LineGraphView(
            lineGraphPointsArray: array,
            lineGraphSettings: lineGraphSettings,
            graphWidth: 350,
            graphHeight: 350
        )

        //Then
        XCTAssertNotNil(sut.body, "Body not found!")
    }

    // MARK: - Test Array min/mid/max and upper/lower quarter
    func testLineGraphArrayMaxValue() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array: [Double] = [-150, -50, -50, 0, 0, 50, 50, 100]

        //When
        _ = sut.calculateArray(array: array)

        //Then
        XCTAssertEqual(sut.maxValue, 100, "Max. Value of the Array is wrong")
    }

    func testLineGraphArrayMidValue() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array: [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]

        //When
        _ = sut.calculateArray(array: array)

        //Then
        XCTAssertEqual(sut.midValue, 25, "Mid Value of the Array is wrong")
    }

    func testLineGraphArrayMinValue() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array: [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]

        //When
        _ = sut.calculateArray(array: array)

        //Then
        XCTAssertEqual(sut.minValue, -150, "Min. Value of the Array is wrong")
    }

    func testLineGraphArrayUpperQuarterValue() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array: [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]

        //When
        _ = sut.calculateArray(array: array)

        //Then
        XCTAssertEqual(sut.upperQuarterValue, 112.5, "Min. Value of the Array is wrong")
    }

    func testLineGraphArrayLowerQuarterValue() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array: [Double] = [-150, -50, -50, 0, 0, 50, 50, 200]

        //When
        _ = sut.calculateArray(array: array)

        //Then
        XCTAssertEqual(sut.lowerQuarterValue, -62.5, "Min. Value of the Array is wrong")
    }

    // MARK: - Array Transformation
    func testLineGraphArrayCalculation() throws {
        //Given

        let sut = LineGraph(lineGraphSettings: lineGraphSettings2, graphHeight: 100)
        let array: [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]

        //When
        let calculatedArray = sut.calculateArray(array: array)

        //Then
        XCTAssertEqual(calculatedArray, [-50.0, -25.0, -25.0, 0.0, 0.0, 25.0, 25.0, 50.0], "Calculation of Array failed") // swiftlint:disable:this line_length
    }

    func testLineGraphTransformation() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings2, graphHeight: 100)
        let array: [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]

        //When
        sut.lineGraphPointsArray = array

        //Then
        let result = [-50.0, -25.0, -25.0, 0.0, 0.0, 25.0, 25.0, 50.0]
        XCTAssertEqual(sut.transformedArray, result, "Transformation of array failed with Result: \(sut.transformedArray)") // swiftlint:disable:this line_length
    }

    func testLineGraphArrayMaxPoints() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array: [Double] = [-100, -50, -50, 0, 0, 50, 50, 100]

        //When
        sut.lineGraphPointsArray = array

        //Then
        XCTAssertEqual(
            sut.transformedArray.count,
            lineGraphSettings.maxPoints,
            "Limiting items in Array to \(lineGraphSettings.maxPoints) failed with \(sut.transformedArray.count) items in Array" // swiftlint:disable:this line_length
        )
    }

    // MARK: - Performance Tests
    func testPerformanceOfArrayCalculation() throws {
        //Given
        let sut = LineGraph(lineGraphSettings: lineGraphSettings, graphHeight: 350)
        let array = Array(stride(from: -1000.0, through: 1000.0, by: 0.1))

        //Measure
        measure {
            _ = sut.calculateArray(array: array)
        }
    }

    func testPerformanceOfLineGraphViewGeneration() throws {
        //Given
        let lineGraphSettings = LineGraphSettings(
            maxPoints: 1000,
            decimalDigits: 3,
            lineWidth: 2,
            lineColor: [.red, .yellow, .green],
            textColor: .primary
        )
        let array = Array(stride(from: -1000.0, through: 1000.0, by: 0.1))

        //Measure
        measure {
            _ = LineGraphView(
                lineGraphPointsArray: array,
                lineGraphSettings: lineGraphSettings,
                graphWidth: 350,
                graphHeight: 350
            )
        }
    }
}
