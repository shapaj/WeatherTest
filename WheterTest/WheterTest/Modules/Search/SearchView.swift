//
//  SearchView.swift
//  WheterTest
//
//  Created by Ihor on 02.11.2022.
//

import UIKit

protocol SearchViewProtocol: UIViewController, ViewUpdateble, SearchRouterProtocol {
   
}

protocol SearchRouterProtocol {
    func dissmisView(coordinates: Coordinates?)
}

class SearchView: BaseViewController, SearchViewProtocol {
    
    
    var presenter: SearchPresenterProtocol!
    
    var handler: ((Coordinates) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad?()
    }
    
    func updateViewInterface(_ viewModel: Any) {
        
    }
    
    @IBAction func cancelButtonTaped(_ sender: UIBarButtonItem) {
        presenter.cancelButtonTaped()
    }
    
    
    func dissmisView(coordinates: Coordinates?) {
        if let coordinates = coordinates {
            handler?(coordinates)
        }
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
}
