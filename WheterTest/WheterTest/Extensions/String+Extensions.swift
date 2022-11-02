//
//  String+Extensions.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
