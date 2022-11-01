//
//  OWMURLManager.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

enum OWMURLManager: URLManagerProtocol {
    
    case weather(coordinates: Coordinates)
    case forecast(coordinates: Coordinates)

    func createURL() -> URL? {
        switch self {
        case .weather(let coordinates):
            return getURL(urlPaths: ["weather"],
                          queryItems: ["lat": String(coordinates.lat),
                                       "lon": String(coordinates.lon)])
        case .forecast(let coordinates):
            return getURL(urlPaths: ["forecast"],
                          queryItems: ["lat": String(coordinates.lat),
                                       "lon": String(coordinates.lon)])
        }
    }

    func getURL(urlPaths: [String]?, queryItems: [String: String]?) -> URL? {
        guard var urlComponents: URLComponents = URLComponents(string: OWMDefaultValues.apiURL) else { return nil }
        urlPaths?.forEach { urlComponents.path.append("/\($0)") }
        urlComponents.queryItems = queryItems?.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems?.append(URLQueryItem(name: "appid", value: OWMDefaultValues.apiKey))
        urlComponents.queryItems?.append(URLQueryItem(name: "units", value: OWMDefaultValues.units))
        
        return urlComponents.url
    }
}

enum GEOURLManager: URLManagerProtocol {
    
    static let paginationCount = "20"
    
    case direct(name: String)
    case reverse(coordinates: Coordinates)

    func createURL() -> URL? {
        switch self {
        case .direct(let name):
            return getURL(urlPaths: ["direct"],
                          queryItems: ["q": name])
        case .reverse(let coordinates):
            return getURL(urlPaths: ["reverse"],
                          queryItems: ["lat": String(coordinates.lat),
                                       "lon": String(coordinates.lon)])
        }
    }

    func getURL(urlPaths: [String]?, queryItems: [String: String]?) -> URL? {
        guard var urlComponents: URLComponents = URLComponents(string: OWMDefaultValues.geoAPIURL) else { return nil }
        urlPaths?.forEach { urlComponents.path.append("/\($0)") }
        urlComponents.queryItems = queryItems?.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.queryItems?.append(URLQueryItem(name: "limit", value: Self.paginationCount))
        urlComponents.queryItems?.append(URLQueryItem(name: "appid", value: OWMDefaultValues.apiKey))
        
        return urlComponents.url
    }
}
