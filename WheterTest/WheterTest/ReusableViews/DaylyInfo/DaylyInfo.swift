//
//  DaylyInfo.swift
//  WheterTest
//
//  Created by Ihor on 30.10.2022.
//

import UIKit
import Nuke

protocol DaylyInfoDelegate: AnyObject {
    func tapToPickLocation()
    func updateWithLocation(_ location: Coordinates?)
}

class DaylyInfo: UIView, Loadable, ViewUpdateble {
    
    var dataManager = DataManager()
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

        cityImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToPickLocation)))
        cityName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapToPickLocation)))
        
        location = dataManager.getsavedCoordinates()
    }
    
    private func updatePartsOfDay(_ partOfDayModels: [PartsOfDayWeather]) {
        guard self.partsOfDay.count == partOfDayModels.count else { return }
        self.partsOfDay.forEach { partOfDay in
            partOfDay.setupView(partOfDay.index(ofAccessibilityElement: partOfDay))
        }
    }
    
    override func draw(_ rect: CGRect) {
        delegate?.updateWithLocation(location)
    }
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        location = nil
        delegate?.updateWithLocation(nil)
    }
  
    @objc func tapToPickLocation(_ sender: UITapGestureRecognizer) {
        delegate?.tapToPickLocation()
    }
    
    func didPickLocation(location: Coordinates) {
        self.location = location
        delegate?.updateWithLocation(location)
    }
    
    func setupView(_ viewModel: Any) {
        if let viewModel = viewModel as? DaylyInfoViewModel {
            
            location = viewModel.location
            datePresentation.text = viewModel.datePresentation
            temperatureLabel.text = viewModel.temperature
            humidityLabel.text = viewModel.humidity
            windLabel.text = viewModel.wind
            
            loadImage(with: viewModel.weatherIconURL, into: currentWeatherIcon)
            
        } else if let viewModel = viewModel as? GeoCityViewModel {
            cityName.text = viewModel.cityName
        } else if let viewModel = viewModel as? [PartsOfDayWeather] {
            updatePartsOfDay(viewModel)
        }
    }
}

struct GeoCityViewModel {
    let cityName: String
    
    init(model: GeoCityModel) {
        cityName = model.name
    }
}
