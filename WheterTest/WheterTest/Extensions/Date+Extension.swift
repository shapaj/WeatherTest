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
        formatter.dateFormat = "E, d MMM y HH:mm"
        return formatter.string(from: self)
    }
    
    func timeFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

extension Int64 {
    func inDate(_ timeZone: Int64 = 0) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(integerLiteral: self + timeZone - Int64(TimeZone.current.secondsFromGMT())))
    }
}
