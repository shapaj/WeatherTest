//
//  GeoCityModel.swift
//  WheterTest
//
//  Created by Ihor on 01.11.2022.
//

import Foundation

struct GeoCityModel: Decodable {
    
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
    var coordinates: Coordinates {
        get { Coordinates(lon: lon, lat: lat) }
    }

    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case lat = "lat"
        case lon = "lon"
        case country = "country"
        case state = "state"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encode(country, forKey: .country)
        try container.encode(state, forKey: .state)


    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = (try? container.decode(String.self, forKey: .name)) ?? ""
        lat = (try? container.decode(Double.self, forKey: .lat)) ?? 0
        lon = (try? container.decode(Double.self, forKey: .lon)) ?? 0
        country = (try? container.decode(String.self, forKey: .country)) ?? ""
        state = (try? container.decode(String.self, forKey: .state)) ?? ""
    }
    
}

struct SearchResultViewModel {
    var cityName: String
    
    init(model: GeoCityModel) {
        cityName = model.name + ", " + model.country + ", " + model.state
    }
}
