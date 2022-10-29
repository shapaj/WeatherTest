//
//  DayViewCell.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit

class DayViewCell: UITableViewCell, ViewUpdateble {

    static let height = CGFloat(60)
    
    @IBOutlet private weak var dayOfWeek: UILabel!
    @IBOutlet private weak var temperatures: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        clearView()
    }
    
    private func clearView() {
        dayOfWeek.text = nil
        temperatures.text = nil
        icon.image = DefaultValues.Images.noImage
    }
    
    func setupView(_ viewModel: Any) {
        guard let viewModel = viewModel as? DayViewCellViewModel else { return }
        
        dayOfWeek.text = viewModel.dayOfWeek
        temperatures.text = viewModel.temperatures
        
    }
    
}

struct DayViewCellViewModel {
    var dayOfWeek: String
    var temperatures: String
    var iconURL: String
   
//    init (model: WeatherInfo, date: Date) {
//
//    }
    
    static func mock() -> Self {
        DayViewCellViewModel(dayOfWeek: "M", temperatures: "21°C/35°C", iconURL: "http://openweathermap.org/img/wn/10d@2x.png")
    }
}
