//
//  CurrentWeatherModel.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

struct WeatherRepresention: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WeatherInfo: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Double // hPa
    let humidity: Int // vlazhnost
    let sea_level: Double // hPa
    let grnd_level: Double // hPa
    let temp_kf: Double?
}

struct Coordinates: Decodable {
    var lon: Double
    var lat: Double
}

struct WindModel: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Clouds: Decodable {
    let all: Int
}

struct Sys: Decodable {
    let type: Int //": 2,
    let id: Int//": 2004688,
    let country: String//": "IT",
    let sunrise: Int//": 1667022522,
    let sunset: Int//": 1667059838
}

struct CurrentWeatherModel: Decodable {
    let coord : Coordinates
    let weather : [WeatherRepresention]
    let base: String
    let main: WeatherInfo
    let visibility: Int
    let wind: WindModel
    let clouds: Clouds
    let dt: Int // 1667058302,
    let sys: Sys
    let timezone: Int // 7200,
    let id: Int // City ID expl:3163858,
    let name: String // City name expl:"Zocca",
    let cod: Int // request status 200
}
