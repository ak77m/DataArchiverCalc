//
//  Arhiver.swift
//  Storage capacity calculator
//
//  Created by ak77m on 03.10.2020.
//

import Foundation

struct Calculator {
    var magazinesNumber : Int
    var raidLevel : Int         // 0-Raid0, 1-Raid5, 2-Raid6, 3 - Raw (unformatted)
    var currentSystem : Int     // 0-DA3s, 1-DA3, 2-DA4

    var selectedVolume : Float     // capacity for 1 magazines with RAID
    var totalVolume : Float {      // total capacity for selected RAID
        Float(magazinesNumber) * selectedVolume
    }
    
    init(magazinesNumber : Int, raid : Int, volume : Float, system: Int) {
        self.magazinesNumber = magazinesNumber
        raidLevel = raid
        selectedVolume = volume
        currentSystem = system
    }
    
    // Magazines capacity(volume) constants for different RAID
    let daMagazine = [ CalcData(system:"DA3s", capacity:3.6, r:[3.42, 2.85, 2.28, 3.6]),
                       CalcData(system:"DA3",  capacity:3.6, r:[3.42, 3.14, 2.85, 3.6]),
                       CalcData(system:"DA4",  capacity:6.0, r:[5.63, 5.16, 4.69, 6.0])]
    
     func volume() -> Float {
        daMagazine[currentSystem].diskVolume[raidLevel]
    }
    
    func maxCapacity() -> Int {
        if raidLevel > daMagazine[currentSystem].diskVolume.count-1 {
            print("RAID index is out of range")
            return 0
        }
        return Int(round(selectedVolume * 76 * 7))
    }
    
}
