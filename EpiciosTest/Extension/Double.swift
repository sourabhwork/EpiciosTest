//
//  Double.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation

extension Double {
    
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}
