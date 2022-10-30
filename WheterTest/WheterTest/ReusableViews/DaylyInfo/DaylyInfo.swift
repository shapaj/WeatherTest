//
//  DaylyInfo.swift
//  WheterTest
//
//  Created by Ihor on 30.10.2022.
//

import UIKit
import Nuke

protocol DaylyInfoDelegate: AnyObject {
    func updateForCurrentLocation()
    func tapToPickLocation()
}

class DaylyInfo: UIView, Loadable, ViewUpdateble {
    
    var location: Coordinates?
    weak var delegate: DaylyInfoDelegate?
    
    @IBOutlet weak var view: UIView!
    @IBOutlet private weak var cityImage: UIImageView!
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var datePresentation: UILabel!
    @IBOutlet private weak var currentWeatherIcon: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var windLabel: UILabel!
    @IBOutlet private weak var partsOfDayStackView: UIStackView!    
    @IBOutlet var partsOfDay: [PartOfDay]!

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
        
        cityImage.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(tapToPickLocation(_:))))
        cityName.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(tapToPickLocation(_:))))
    }
    
    private func updatePartsOfDay(_ partOfDayModels: [PartsOfDayWeather]) {
        guard self.partsOfDay.count == partOfDayModels.count else { return }
        self.partsOfDay.forEach { partOfDay in
            partOfDay.setupView(partOfDay.index(ofAccessibilityElement: partOfDay))
        }
        
    }
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        delegate?.updateForCurrentLocation()
    }
  
    @objc func tapToPickLocation(_ sender: UITapGestureRecognizer) {
        delegate?.tapToPickLocation()
    }
    
    func setupView(_ viewModel: Any) {
        if let viewModel = viewModel as? DaylyInfoViewModel {
            
            location = viewModel.location
            cityName.text = viewModel.cityName
            datePresentation.text = viewModel.datePresentation
            temperatureLabel.text = viewModel.temperature
            humidityLabel.text = viewModel.humidity
            windLabel.text = viewModel.wind
            
            loadImage(with: viewModel.weatherIconURL, into: currentWeatherIcon)
            
        } else if let viewModel = viewModel as? [PartsOfDayWeather] {
            updatePartsOfDay(viewModel)
        }
    }
}

struct DaylyInfoViewModel {
    let location: Coordinates
    let cityName: String
    let datePresentation: String
    let weatherIconURL: URL?
    let temperature: String
    let humidity: String
    let wind: String
    let partsOfDayWeather: [PartsOfDayWeather]
    
    // TODO: INIT
}
