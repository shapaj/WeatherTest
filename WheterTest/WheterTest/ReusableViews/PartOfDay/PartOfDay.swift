//
//  PartOfDay.swift
//  WheterTest
//
//  Created by Ihor on 30.10.2022.
//

import UIKit
import Nuke

class PartOfDay: UIView, Loadable, ViewUpdateble {
   
    @IBOutlet weak var view: UIView!
    @IBOutlet private weak var timeTitle: UILabel!
    @IBOutlet private weak var weaterIcon: UIImageView!
    @IBOutlet private weak var temperatureTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupElements()
    }
    
    private func setupElements() {
        loadView()
        view.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
        view.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func updateViewInterface(_ viewModel: Any) {
        if let viewModel = viewModel as? PartOfDayWeatherViewModel {
            timeTitle.text = viewModel.timeTitle
            temperatureTitle.text = viewModel.temperatureTitle
            
            loadImage(with: viewModel.weaterIconURL, into: weaterIcon)
        }
    }
}

struct PartOfDayWeatherViewModel {
    let timeTitle: String
    let weaterIconURL: URL?
    let temperatureTitle: String
    
    init(model: TimeForcastModel, city: CityModel) {
        timeTitle = model.dt.inDate(city.timezone).timeFormat()
        weaterIconURL = OWMURLManager.weatherIcon(model.weather.first?.icon, size: .normal).createURL()
        temperatureTitle = model.main.temp.getPresentation()
        
    }
}
