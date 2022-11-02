//
//  OWMNetworkService.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation
import Swinject

protocol NetworkService {
    
    var networkManager: NetworkManager? { get set }
    func getWeather(coordinates: Coordinates, complition: @escaping(Result<CurrentWeatherModel, Error>) -> Void)
    func getForecast(coordinates: Coordinates, complition:  @escaping(Result<WeeklyWeatherModel, Error>) -> Void)
    func getCityByName(name: String, complition: @escaping(Result<[GeoCityModel], Error>) -> Void)
    func getCityByCoordinates(coordinates: Coordinates, complition: @escaping(Result<[GeoCityModel], Error>) -> Void)
    
}

class OWMNetworkService: NetworkService {
    var networkManager: NetworkManager?
    
    func getWeather(coordinates: Coordinates, complition: @escaping (Result<CurrentWeatherModel, Error>) -> Void) {
        let url = OWMURLManager.weather(coordinates: coordinates).createURL()
        print(url!)
        networkManager?.getModel(url: url, headers: nil, parametres: nil, completionHandler: complition)
    }
    
    func getForecast(coordinates: Coordinates, complition: @escaping (Result<WeeklyWeatherModel, Error>) -> Void) {
        let url = OWMURLManager.forecast(coordinates: coordinates).createURL()
        print(url!)
        networkManager?.getModel(url: url, headers: nil, parametres: nil, completionHandler: complition)
    }
    
    func getCityByName(name: String, complition: @escaping(Result<[GeoCityModel], Error>) -> Void) {
        let url = GEOURLManager.direct(name: name).createURL()
        networkManager?.getModel(url: url, headers: nil, parametres: nil, completionHandler: complition)
    }
    
    func getCityByCoordinates(coordinates: Coordinates, complition: @escaping(Result<[GeoCityModel], Error>) -> Void) {
        let url = GEOURLManager.reverse(coordinates: coordinates).createURL()
        networkManager?.getModel(url: url, headers: nil, parametres: nil, completionHandler: complition)
    }
    
    init(container: Container) {
        networkManager = container.resolve(NetworkManager.self)
    }
}
