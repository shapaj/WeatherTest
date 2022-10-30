//
//  WeeklyWeatherModel.swift
//  WheterTest
//
//  Created by Ihor on 30.10.2022.
//

import Foundation


struct CityModel: Decodable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}

struct TimeForcastModel: Decodable {
    let id: Int
    let main: WeatherInfo
    let weather : [WeatherRepresention]
    let clouds: Clouds
    let wind: WindModel
    let visibility: Int
    let pop: Int
    let sys: Sys
    let dt_txt: String
}

struct WeeklyWeatherModel: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [TimeForcastModel]
    let city: CityModel
}
