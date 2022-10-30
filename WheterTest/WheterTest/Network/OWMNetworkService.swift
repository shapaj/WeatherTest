//
//  OWMNetworkService.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

protocol NetworkService {
    func printData()
}

class OWMNetworkService: NetworkService {
    func printData() {
        print("Test")
    }
    
    
}
