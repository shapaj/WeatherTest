//
//  DaysOfWeek.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

enum DaysOfWeek: String, CaseIterable {
    case monday = "Monday"
    case tuesday = "Tuesday"
    case wednesday = "Wednesday"
    case thursday = "Thursday"
    case friday = "Friday"
    case saturday = "Saturday"
    case Sunday = "Sunday"
    
    
    func representation() -> String {
        self.rawValue.localized()
    }
}
