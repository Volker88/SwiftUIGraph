//
//  ExtensionTests.swift
//  SwiftUIGraph
//
//  Created by Volker Schmitt on 30.12.19.
//  Copyright © 2021 Volker Schmitt. All rights reserved.
//

import XCTest
@testable import SwiftUIGraph

final class ExtensionTests: XCTestCase {

    var barDataPointArray: [BarDataPoint] {
        [
            BarDataPoint(id: 1, value: 200, color: .red, title: "Yes"),
            BarDataPoint(id: 4, value: 300, color: .blue, title: "N/A"),
            BarDataPoint(id: 3, value: 400, color: .green, title: "No"),
            BarDataPoint(id: 2, value: 100, color: .yellow, title: "Maybe")
        ]
    }

    func testDoubleExtensionRoundUp()  throws {
        //Given
        let number = 100.000005
        let decimalDigits = 5

        //When
        let rounded = number.rounded(toPlaces: decimalDigits)

        //Then
        XCTAssertEqual(rounded, 100.00001, "Rounded \(number) to \(rounded) does not equal 100.00001")
    }

    func testDoubleExtensionRoundDown()  throws {
        //Given
        let number = 100.111114
        let decimalDigits = 5

        //When
        let rounded = number.rounded(toPlaces: decimalDigits)

        //Then
        XCTAssertEqual(rounded, 100.11111, "Rounded \(number) to \(rounded) does not equal 100.11111")
    }

    func testArrayExtensionCustomSortByID() throws {
        //Given
        let array = barDataPointArray

        //When
        let sorted = array.customSort(by: .id)

        //Then
        let result = sorted.compactMap { $0.value}
        XCTAssertEqual(result, [200, 100, 400, 300], "Array is not sorted by ID")
    }

    func testArrayExtensionCustomSortByValueAscending() throws {
        //Given
        let array = barDataPointArray

        //When
        let sorted = array.customSort(by: .valueAscending)

        //Then
        let result = sorted.compactMap { $0.value}
        XCTAssertEqual(result, [100, 200, 300, 400], "Array is not sorted by ID")
    }

    func testArrayExtensionCustomSortByValueDescending() throws {
        //Given
        let array = barDataPointArray

        //When
        let sorted = array.customSort(by: .valueDescending)

        //Then
        let result = sorted.compactMap { $0.value}
        XCTAssertEqual(result, [400, 300, 200, 100], "Array is not sorted by ID")
    }
}
