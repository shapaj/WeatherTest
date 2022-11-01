//
//  Date+Extension.swift
//  WheterTest
//
//  Created by Ihor on 01.11.2022.
//

import Foundation

extension Date {
    func presentation() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM y"
        return formatter.string(from: self)
    }
}

extension Int64 {
    func inDate() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(integerLiteral: self))
    }
}
