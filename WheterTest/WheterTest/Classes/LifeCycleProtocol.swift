//
//  LifeCycleProtocol.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

@objc protocol LifeCycleProtocol {
    @objc optional func viewDidLoad()
    @objc optional func viewWillAppear()
    @objc optional func viewDidAppear()
    @objc optional func viewWillDisappear()
    @objc optional func viewDidDisappear()
}
