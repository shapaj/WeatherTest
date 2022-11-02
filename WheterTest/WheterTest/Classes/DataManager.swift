//
//  DataManager.swift
//  WheterTest
//
//  Created by Ihor on 01.11.2022.
//

import Foundation

class DataManager {
    
    private enum ValueCases: String {
        case curentLocation
    }
    
    func saveCoordinates(location: Coordinates?) {
        encodeData(value: location, key: .curentLocation)
    }
    
    func getsavedCoordinates() -> Coordinates? {
        return decodeData(key: .curentLocation)
    }
    
    private func encodeData<T:Codable>(value: T, key: ValueCases) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key.rawValue)
        }
    }
    
    private func decodeData<T:Codable>(key: ValueCases) -> T? {
        guard let savedPerson = UserDefaults.standard.object(forKey: key.rawValue) as? Data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: savedPerson)
    }
}
