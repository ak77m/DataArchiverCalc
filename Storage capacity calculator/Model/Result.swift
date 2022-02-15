//
//  System.swift
//  Storage capacity calculator
//
//  Created by ak77m on 14.10.2020.
//

import Foundation


struct Result {
    
    var magazinesNumber = 0
    var systemName : Int?
    
    var systemNameString : String {
        switch systemName {
        case 0:
            return "DA3s"
        case 1:
            return "DA3"
        default:
            return "DA4"
        }
    }
    
    var magazinesSets = [0,0,0]
    
    var magazinesInSets : Int {
        return magazinesSets[0]*30+magazinesSets[1]*16+magazinesSets[2]*5
    }
    
    func createSpecification() -> [ResultData] {
        var sys : [ResultData] = []
        
        var da3 = 0
        var da4 = 0
        var driveUnit = 0
        var sas = 0
        var expUnit = Int(ceil(Double(magazinesInSets) / 76))
        var powerSupply = 1
        
        switch systemName {
        case 0: // "DA3s"
            da3 = 1
            driveUnit = 0
            sas = 0
            
            if magazinesInSets < 76 {
                expUnit = 0
            } else {
                expUnit -= 1
            }
            powerSupply = 1
            
        case 1: // "DA3"
            da3 = 1
            driveUnit = 1
            sas = 1
            if magazinesInSets < 76*2 {
                expUnit = 0
            } else {
                expUnit -= 2
            }
            powerSupply = 2
            
        default: // "DA4"
            da4 = 1
            driveUnit = 1
            sas = 1
            if magazinesInSets < 76*2 {
                expUnit = 0
            } else {
                expUnit -= 2
            }
            powerSupply = 2
            
        }
        
        // DA3 items
        sys.append(ResultData(name: "Bottom Unit", m: "LB-DF81Z1R",             q: da3, h: 4, w: 23.0))
        sys.append(ResultData(name: "Base Unit", m: "LB-DH70A0R",               q: da3, h: 6, w: 40.0))
        sys.append(ResultData(name: "Expansion Unit (drive)", m: "LB-DF72A0R",  q: da3 * driveUnit, h: 6, w: 39.0))
        sys.append(ResultData(name: "Expansion Unit", m: "LB-DH82Z1R",          q: da3 * expUnit, h: 6, w: 29.0))
        sys.append(ResultData(name: "Magazines pack 30", m: "LM-BM36XB30",      q: da3 * magazinesSets[0], h: 0, w: 9.0))
        sys.append(ResultData(name: "Magazines pack 16", m: "LM-BM36XB16",      q: da3 * magazinesSets[1], h: 0, w: 4.8))
        sys.append(ResultData(name: "Magazines pack 5", m: "LM-BM36XB5",        q: da3 * magazinesSets[2], h: 0, w: 1.5))
        sys.append(ResultData(name: "Straight SAS cable 2.0m", m: "LB-XA20H0R", q: da3 * 2, h: 0, w: 0.3))
        sys.append(ResultData(name: "Biforked SAS cable 2.0m", m: "LB-XA20J0R", q: da3 * sas, h: 0, w: 0.3))
        // DA4 items
        sys.append(ResultData(name: "Bottom Unit", m: "LB-DF81Z6G/C",            q: da4, h: 4, w: 23.0))
        sys.append(ResultData(name: "Base Unit", m: "LB-DH60A7G/C",              q: da4, h: 6, w: 43.0))
        sys.append(ResultData(name: "Expansion Unit (drive)", m: "LB-DH62A7G/C", q: da4 * driveUnit, h: 6, w: 42.0))
        sys.append(ResultData(name: "Expansion Unit", m: "LB-DH62Z7G/C",         q: da4 * expUnit, h: 6, w: 32.0))
        sys.append(ResultData(name: "Magazines pack 30", m: "LM-BM60XB30",       q: da4 * magazinesSets[0], h: 0, w: 9.0))
        sys.append(ResultData(name: "Magazines pack 16", m: "LM-BM60XB16",       q: da4 * magazinesSets[1], h: 0, w: 4.8))
        sys.append(ResultData(name: "Magazines pack 5", m: "LM-BM60XB5",         q: da4 * magazinesSets[2], h: 0, w: 1.5))
        sys.append(ResultData(name: "Basic cable set", m: "LB-XA30P0E",          q: da4, h: 0, w: 1.0))
        sys.append(ResultData(name: "Support angle unit", m: "LB-XF101",         q: da4 * (expUnit + 3), h: 0, w: 1.6))
        // Universal items
        sys.append(ResultData(name: "Server", m: "XXX",                         q: 1, h: 2, w: 30.0))
        sys.append(ResultData(name: "Control software", m: "XXX",               q: 1, h: 0, w: 0.0))
        sys.append(ResultData(name: "Power supply rack", m: "HFE1600-S1U",      q: 2, h: 1, w: 4.8))
        sys.append(ResultData(name: "Power supply 24DC", m: "HFE1600-24/S",     q: powerSupply, h: 0, w: 5.6))
        sys.append(ResultData(name: "Power supply 12DC", m: "HFE1600-12/S",     q: powerSupply, h: 0, w: 5.6))
        sys.append(ResultData(name: "Power cable", m: "XXX",                    q: powerSupply * 2, h: 0, w: 0.2))
        
        // Remove all rows containing 0 in quantity
        sys = sys.filter { $0.quantity != 0 }
        
        return sys
    }
    
    func summary(_ spec: [ResultData]) -> [Int] {
        var height = 0
        var weight = 0.0
        
        for i in spec {
            height += i.quantity * i.height
            weight += Double(i.quantity) * i.weight
        }
        return [magazinesInSets, height, height - 4, Int(round(weight))]
    }
    
    
}
// MARK: - calculation of the Packs(Sets) number

extension Result {
    
    func optimalSet() -> [Int] {
        
        func divCheck(_ inValue: Int) -> Bool {
            for i in 0 ..< magazinesSetType.count {
                if (inValue % magazinesSetType[i]) == 0 {
                    packs[i] += inValue / magazinesSetType[i]
                    
                    // One 30pack equal 5pack * 6
                    if packs[2] > 6 {
                        packs[0] += packs[2] / 6
                        packs[2] = packs[2] % 6
                    }
                    //print("Решение найдено")
                    return true
                }
            }
            return false
        }
       
        //print("Решаем для числа \(magazinesNumber)")
        let magazinesSetType = [30,16,5]
        var packs = [0,0,0]
        var tempValue = magazinesNumber
        var realMagazinesNumber = magazinesNumber
        
        while tempValue != 0 {
            tempValue = realMagazinesNumber
            if divCheck(tempValue) { return packs }
            
            while (tempValue - 16) >= 5 {
                tempValue -= 16
                packs[1] += 1
                if divCheck(tempValue) { return packs }
            }
            
            realMagazinesNumber += 1
            //print("Решаем для числа \(realMagazinesNumber)")
            packs = [0,0,0]
        }
        return packs
    }
    
}
