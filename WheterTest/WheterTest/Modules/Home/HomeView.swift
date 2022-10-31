//
//  HomeView.swift
//  WheterTest
//
//  Created by Ihor on 29.10.2022.
//

import UIKit
import CoreLocation

final class HomeView: BaseViewController, HomeViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    //private static let numberOfSections = 1
    
    @IBOutlet weak var daylyInfoView: DaylyInfo!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    private var tableViewModel = [DayViewCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter.viewDidLoad?()
        view.backgroundColor = .yellow
    }
    
    private func setupViewController() {
        daylyInfoView.delegate = presenter
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(UINib.init(nibName: DayViewCell.getIdentifier(), bundle: Bundle.main), forCellReuseIdentifier: DayViewCell.getIdentifier())
    }
    
    func setupView(_ viewModel: Any) {
        if let viewModel = viewModel as? [DayViewCellViewModel] {
            tableViewModel = viewModel
            tableView.reloadData()
        } else if let location = viewModel as? Coordinates {
            daylyInfoView.didPickLocation(location: location)
        } else if let viewModel = viewModel as? DaylyInfoViewModel {
            daylyInfoView.setupView(viewModel)
        } else {
            fatalError("uninspectable type \(viewModel.self)")
        }
    }
    
    // MARK: TableView  dataSourse/delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DayViewCell.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DayViewCell.getIdentifier()) as? DayViewCell else {
            assertionFailure("oups... ckrash")
            return UITableViewCell()
        }
        cell.setupView(tableViewModel[indexPath.row])

        return cell
    }
}
