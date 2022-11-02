//
//  CurrentWeatherModel.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

typealias Temperature = Double

struct WeatherRepresention: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherInfo: Decodable {
    let temp: Temperature
    let feels_like: Double?
    let temp_min: Temperature
    let temp_max: Temperature
    let pressure: Double? // hPa
    let humidity: Int // vlazhnost
    let sea_level: Double? // hPa
    let grnd_level: Double? // hPa
    let temp_kf: Temperature?
}

struct Coordinates: Codable {
    var lon: Double
    var lat: Double
    
    static func mock() -> Coordinates {
        return Coordinates(lon: 10.99, lat: 44.34)
    }
}

struct WindModel: Decodable {
    let speed: Double
    let deg: Int?
    let gust: Double?
}

struct Clouds: Decodable {
    let all: Int
}

struct CurrentWeatherModel: Decodable {
    let coord: Coordinates
    let weather: [WeatherRepresention]
    let base: String?
    let main: WeatherInfo
    let visibility: Int?
    let wind: WindModel
    let clouds: Clouds?
    let dt: Int64 // 1667058302,
    let timezone: Int64 // 7200,
    let id: Int64 // City ID expl:3163858,
    let name: String // City name expl:"Zocca",
    let cod: Int // request status 200
}

struct DaylyInfoViewModel {
    let location: Coordinates
    let datePresentation: String
    let weatherIconURL: URL?
    let temperature: String
    let humidity: String
    let wind: String
    
    init(model: CurrentWeatherModel) {
        location = model.coord
        datePresentation =  model.dt.inDate(model.timezone).presentation()
        weatherIconURL = OWMURLManager.weatherIcon(model.weather.first?.icon, size: .normal).createURL()
        temperature = model.main.temp.getPresentation()
        humidity = String(format: "%.0f", model.main.humidity) + "%"
        wind = String(format: "%.1f", model.wind.speed) + "" + DefaultValues.Strings.mitersPerSeccond
    }
}
