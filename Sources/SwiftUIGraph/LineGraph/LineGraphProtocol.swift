//
//  LineGraphProtocol.swift
//  SwiftUIChart
//
//  Created by Volker Schmitt on 19.01.20.
//  Copyright © 2019 Volker Schmitt. All rights reserved.
//


//MARK: - Import
import Foundation


//MARK: - Protocol

///
///    Protocol to add required variables for  LineGraph
///
///   **lineGraphPointsArray:** Array of Doubles to create the graph
///
///   **lineGraphSettings:** Graph Customization
///
///   - Note: For dynamic graphs **lineGraphPointsArray** need to be declared as **@State var**
///
public protocol LineGraphPotocol {
    var lineGraphPointsArray: [Double] { get }
    var lineGraphSettings: LineGraphSettings { get }
}
