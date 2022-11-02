//
//  GeoCityModel.swift
//  WheterTest
//
//  Created by Ihor on 01.11.2022.
//

import Foundation

struct GeoCityModel: Decodable {
    
    let name: String
    let localNames: String?
    let lat: Double
    let lon: Double
    let couuntry: String
    let state: String

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case localNames = "local_names"
        case lat = "lat"
        case lon = "lon"
        case couuntry = "couuntry"
        case state = "state"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(localNames, forKey: .localNames)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(couuntry, forKey: .couuntry)
        try container.encode(state, forKey: .state)


    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = (try? container.decode(String.self, forKey: .name)) ?? ""
        localNames = ""
        lat = (try? container.decode(Double.self, forKey: .lat)) ?? 0
        lon = (try? container.decode(Double.self, forKey: .lon)) ?? 0
        couuntry = (try? container.decode(String.self, forKey: .couuntry)) ?? ""
        state = (try? container.decode(String.self, forKey: .state)) ?? ""
    }
    
}
