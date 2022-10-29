//
//  UIView+Extensions.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit

extension UIView {
    static func getIdentifier() -> String {
        return String(describing: Self.self)
    }
}
