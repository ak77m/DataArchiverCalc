//
//  DataFormat.swift
//  Storage capacity calculator
//
//  Created by ak77m on 13.10.2020.
//

import Foundation

//General structure of magazines properties
struct ResultData {
    let name: String
    let model: String
    var quantity: Int
    let height : Int // Height in Units
    let weight: Double
    
    init(name: String, m: String, q: Int, h: Int, w: Double) {
        self.name = name
        model = m
        quantity = q
        height = h
        weight = w
    }
}
