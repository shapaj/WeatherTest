//
//  HomePresenter.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    private var view: HomeViewProtocol?
    var networkService: NetworkService = OWMNetworkService()
    private var currentWeatherModel: CurrentWeatherModel?
//    private var weeklyWeatherModel: WeeklyWeatherModel?
    
    init(view: HomeViewProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        getCurrentWeather()
        getWeeklyFircast()
    }
    
    private func getCurrentWeather() {
        // TODO: NetworkService.getCurrentWeather()
        
    }
    
    private func getWeeklyFircast() {
        // TODO: getWeeklyFircast.getCurrentWeather()
    }
}
