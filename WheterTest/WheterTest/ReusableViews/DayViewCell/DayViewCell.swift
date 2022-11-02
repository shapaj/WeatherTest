//
//  DayViewCell.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit
import Nuke

class DayViewCell: UITableViewCell, ViewUpdateble {

    static let height = CGFloat(60)
    
    @IBOutlet private weak var dayOfWeek: UILabel!
    @IBOutlet private weak var temperatures: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        clearView()
    }
    
    private func clearView() {
        dayOfWeek.text = nil
        temperatures.text = nil
        icon.image = DefaultValues.Images.noImage
    }
    
    func updateViewInterface(_ viewModel: Any) {
        guard let viewModel = viewModel as? DayViewCellViewModel else { return }
        
        dayOfWeek.text = viewModel.dayOfWeek
        temperatures.text = viewModel.temperatures
        loadImage(with: viewModel.iconURL, into: icon)
    }
    
}

class ForcastDay {
    
    var date: Date
    var iconURL: URL?
    private (set) var tempMin: Temperature = 1000
    private (set) var tempMax: Temperature = -273
    
    var daylyForcast: [PartOfDayWeatherViewModel] = []
    
    func setMax(newValue: Temperature) {
        tempMax = max(newValue, tempMax)
    }
    
    func setMin(newValue: Temperature) {
        tempMin = min(newValue, tempMin)
    }
    
    init(date: Date) {
        self.date = date
    }
}

struct DayViewCellViewModel {
    var dayOfWeek: String?
    var temperatures: String
    var iconURL: URL?
   
    init (model: ForcastDay) {
        dayOfWeek = model.date.dayOfWeek()
        temperatures = model.tempMin.getPresentation() + " / " + model.tempMax.getPresentation()
        iconURL = model.iconURL
    }
    
    init(dayOfWeek: String, temperatures: String, iconURL: String) {
        self.dayOfWeek = dayOfWeek
        self.temperatures = temperatures
        self.iconURL = URL(string: iconURL)
    }
    
    static func mock() -> Self {
        DayViewCellViewModel(dayOfWeek: "M", temperatures: "21°C/35°C", iconURL: "http://openweathermap.org/img/wn/10d@2x.png")
    }
}
