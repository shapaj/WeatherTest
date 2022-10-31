//
//  HomePresenter.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation
import Swinject

final class HomePresenter: HomePresenterProtocol {
    
    private var view: HomeViewProtocol?
    
    var networkService: NetworkService?
    var locationService: LocationService?
    
    private var currentWeatherModel: CurrentWeatherModel?
    private var weeklyWeatherModel: WeeklyWeatherModel?
    
    init(view: HomeViewProtocol, container: Container) {
        self.view = view
        self.networkService = container.resolve(NetworkService.self)
        self.locationService = container.resolve(LocationService.self)
    }
    
    // MARK: view life cycle protocol methods
    
    func viewDidLoad() {}
    
    // MARK: private methods
    
    private func updateLocation() {
        locationService?.getCurrentLocation { [view] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coordinates):
                    view?.setupView(coordinates)
                case .failure(let alert):
                    view?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func getCurrentWeather(_ location: Coordinates) {
        networkService?.getWeather(coordinates: location) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.currentWeatherModel = weather
            case .failure(let error):
                self?.view?.presentAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func getWeeklyForcast(_ location: Coordinates) {
        networkService?.getForecast(coordinates: location) { [weak self] result in
            switch result {
                
            case .success(let weeklyWeather):
                self?.weeklyWeatherModel = weeklyWeather
            case .failure(let error):
                self?.view?.presentAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func updateWeather(_ location: Coordinates) {
        getCurrentWeather(location)
        getWeeklyForcast(location)
    }
    
    // MARK: dayly view delegate
    
    func tapToPickLocation() {
        print(1)
        // TODO ShowLocationPiker
        // is not correct updateLocation()
    }
    
    func updateWithLocation(_ location: Coordinates?) {
        guard let location = location else {
            updateLocation()
            return
        }
        updateWeather(location)
    }
}
