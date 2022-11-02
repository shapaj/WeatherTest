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

protocol Loadable: UIView {
    var view: UIView! { get }
}

extension Loadable {
    func loadView() {
    Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)
        view.self.frame = bounds
            addSubview(view)
}
}
