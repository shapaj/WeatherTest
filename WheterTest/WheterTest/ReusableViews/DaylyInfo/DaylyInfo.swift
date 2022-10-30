//
//  DaylyInfo.swift
//  WheterTest
//
//  Created by Ihor on 30.10.2022.
//

import UIKit

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupElements()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupElements()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func draw(_ rect: CGRect) {
        //setupElements()
    }
    
    private func setupElements() {
        
        loadView()
        view.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleHeight, .flexibleWidth]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        cityImage.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(tapToPickLocation(_:))))
        cityName.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(tapToPickLocation(_:))))
    }
    
    @IBAction func getCurrentLocation(_ sender: UIButton) {
        delegate?.updateForCurrentLocation()
    }
  
    @objc func tapToPickLocation(_ sender: UITapGestureRecognizer) {
        delegate?.tapToPickLocation()
    }
    
    func setupView(_ viewModel: Any) {
        if let viewModel = viewModel as? DaylyInfoViewModel {
            
        }
    }
}

struct DaylyInfoViewModel {
    
}
