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
    private var currentWeatherModel: CurrentWeatherModel?
    
    init(view: HomeViewProtocol, container: Container) {
        self.view = view
        self.networkService = container.resolve(NetworkService.self)
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
