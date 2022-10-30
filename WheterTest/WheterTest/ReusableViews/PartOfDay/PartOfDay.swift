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
    
    func setupView(_ viewModel: Any) {
        if let viewModel = viewModel as? PartsOfDayWeather {
            timeTitle.text = viewModel.timeTitle
            temperatureTitle.text = viewModel.temperatureTitle
            
            loadImage(with: viewModel.weaterIconURL, into: weaterIcon)
        }
    }
}

struct PartsOfDayWeather {
    let timeTitle: String
    let weaterIconURL: URL?
    let temperatureTitle: String
    
    // TODO: INIT
}
