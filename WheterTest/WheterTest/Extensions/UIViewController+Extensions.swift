//
//  UIViewController+Create.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit

extension UIViewController {
    static func createVC() -> Self {
        let storyBord = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        
        guard let viewController = storyBord.instantiateInitialViewController() as? Self else {
            fatalError("didn't find \(Self.self) view controlled")
        }
        
        return viewController
    }
}

extension UIViewController {
    func presentAlert(message: String, header: String? = nil, heandler: (() -> Void)? = nil) {
        
    }
}
