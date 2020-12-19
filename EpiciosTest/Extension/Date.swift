//
//  Date.swift
//  EpiciosTest
//
//  Created by Sourabh Kumbhar on 19/12/20.
//  Copyright © 2020 Sourabh Kumbhar. All rights reserved.
//

import Foundation


extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "day"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "min" :
            "\(minute)" + " " + "min"
        } else {
            return "a moment"
            
        }        
    }
}
