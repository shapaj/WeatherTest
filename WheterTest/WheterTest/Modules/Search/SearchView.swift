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
    var viewModel = [SearchResultViewModel]()
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter City name"
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        presenter.viewDidLoad?()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView?.backgroundColor = .clear
        tableView.backgroundColor = .clear
    }
    
    func updateViewInterface(_ viewModel: Any) {
        if let viewModel = viewModel as? [SearchResultViewModel] {
            self.viewModel = viewModel
            tableView.reloadData()
        } else {
            fatalError(" invalid data ")
        }
    }
    
    @IBAction func doneButtonTaped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func cancelButtonTaped(_ sender: UIBarButtonItem) {
        presenter.cancelButtonTaped()
    }
    
    func dissmisView(coordinates: Coordinates?) {
        if let coordinates = coordinates {
            handler?(coordinates)
        }
        
        self.navigationItem.searchController?.dismiss(animated: true)
        
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

extension SearchView: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        presenter.cancelButtonTaped()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.serchStringChanged(serchString: searchBar.text)
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = viewModel[indexPath.row].cityName
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = viewModel[indexPath.row].cityName
        }
        cell.backgroundColor = DefaultValues.Colors.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DefaultValues.Numbers.UITableViewCellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath: indexPath)
    }
}
