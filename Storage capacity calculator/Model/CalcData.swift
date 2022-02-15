//
//  File.swift
//  Storage capacity calculator
//
//  Created by ak77m on 04.10.2020.
//

import Foundation

// MARK: - Main structure of magazines properties
struct CalcData {

    var name: String
    var magazineCapacity : Float // DA3 type 3.6, DA4 type 6TB
    var diskVolume: [Float]
    
    init(system : String, capacity : Float, r : [Float]) {
        name = system
        magazineCapacity = capacity
        diskVolume = r
    }
}
