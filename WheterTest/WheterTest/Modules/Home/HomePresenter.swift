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
    var forcastDays: [ForcastDay] = []
    
    private var currentWeatherModel: CurrentWeatherModel?
    private var weeklyWeatherModel: WeeklyWeatherModel?
    private var curentCityModel: GeoCityModel?
    
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
                    view?.updateViewInterface(coordinates)
                case .failure(let alert):
                    view?.present(alert, animated: true)
                }
            }
        }
    }
    
    private func updateCityInfo(coordinates: Coordinates) {
        networkService?.getCityByCoordinates(coordinates: coordinates) { [weak self] result in
            switch result {
            case .success(let cites):
                self?.updateCityOnView(curentCity: cites.first)
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.presentAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func updateCityOnView(curentCity: GeoCityModel?) {
        guard let curentCity = curentCity else { return }
        curentCityModel = curentCity
        
        let viewModel =  GeoCityViewModel(model: curentCity)
        DispatchQueue.main.async { [view] in
            view?.updateViewInterface(viewModel)
        }
    }
    
    private func getCurrentWeather(_ location: Coordinates) {
        networkService?.getWeather(coordinates: location) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.currentWeatherModel = weather
                let viewModel = DaylyInfoViewModel(model: weather)
                DispatchQueue.main.async {
                    self?.view?.updateViewInterface(viewModel)
                }
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
                self?.processingOfModel()
            case .failure(let error):
                self?.view?.presentAlert(message: error.localizedDescription)
            }
        }
    }
    
    private func processingOfModel() {
        guard let weeklyWeather = weeklyWeatherModel else { return }
        let partsOfDayViewModel = weeklyWeather.list.prefix(6).map { model in
            return PartOfDayWeatherViewModel(model: model, city: weeklyWeather.city)
        }
        
        DispatchQueue.main.async { [view] in
            view?.updateViewInterface(partsOfDayViewModel)
        }
        
        let endToday = Date().endOfDay.timeIntervalSince1970
        
        for model in weeklyWeather.list.filter({ TimeInterval($0.dt) > endToday }) {

            if forcastDays.isEmpty {
                forcastDays.append(ForcastDay(date: model.dt.inDate().startOfDay))
            }
            
            if let curentForcast = forcastDays.last,
               model.dt.inDate() > curentForcast.date.endOfDay {
                forcastDays.append(ForcastDay(date: model.dt.inDate().startOfDay))
            }
                
            if let curentForcast = forcastDays.last {
                curentForcast.setMax(newValue: model.main.temp_max)
                curentForcast.setMin(newValue: model.main.temp_min)
                curentForcast.iconURL = OWMURLManager.weatherIcon(model.weather.first?.icon, size: .normal).createURL()
            }
        }
        
        let forcastDaysModel = forcastDays.compactMap { DayViewCellViewModel(model: $0) }
        DispatchQueue.main.async { [view] in
            view?.updateViewInterface(forcastDaysModel)
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
        
        updateCityInfo(coordinates: location)
        updateWeather(location)
    }
    
    func tapToPickLocationOnMap () {
        view?.presentMap()
    }
}
