//
//  Temperature+Extension.swift
//  WheterTest
//
//  Created by Ihor on 01.11.2022.
//

import Foundation

extension Temperature {
    func getPresentation() -> String {
        String(format: "%.0f", self) + DefaultValues.Strings.gradusCelsiusLit
    }
}
