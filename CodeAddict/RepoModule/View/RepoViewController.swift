//
//  RepoViewController.swift
//  CodeAddict
//
//  Created by Дмитрий on 08/12/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import UIKit
import SnapKit

class RepoViewController: UIViewController {

    var presenter: RepoViewPresenterProtocol!
    let searchController = UISearchController(searchResultsController: nil)
    let tableView = UITableView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var errorAlert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpSearchController()
        setUpTableView()
        setUpActivityIndicator()
        
    }
    
    //MARK: set up UI
    private func setUpSearchController() {
        self.title = "Search"
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }

    private func setUpTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        tableView.separatorStyle = .none
        
        tableView.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview()
            maker.top.equalToSuperview()
            maker.trailing.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    private func setUpActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.centerY.equalToSuperview()
        }
        activityIndicator.isHidden = true
    }
}

extension RepoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        let repo = presenter.repos[indexPath.row]
        cell.textLabel?.text = repo.name
        return cell
    }
}

extension RepoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let clearView = UIView()
        clearView.backgroundColor = .white
        
        let textLabel = UILabel()
        textLabel.text = "Repositories"
        textLabel.font = UIFont.boldSystemFont(ofSize: 22.0)
        clearView.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(10)
            maker.width.equalToSuperview()
            maker.centerY.equalToSuperview()
            maker.height.equalTo(44)
        }
        
        return clearView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}

extension RepoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text, !searchText.isEmpty, searchText.count != 0 else {
            presenter.repos = []
            tableView.reloadData()
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            return
        }
        presenter.searchRepo(repoName: searchText, page: 1, perPage: 25)
        print("send request")
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        tableView.isHidden = true
    }
}

extension RepoViewController: RepoViewProtocol {
    func success() {
        print("Success")
        guard let text = searchController.searchBar.text, !text.isEmpty, text.count != 0 else { return }
        tableView.reloadData()
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        tableView.isHidden = false
    }
    
    func failure(error: Error) {
        print("Error")
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        errorAlert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        errorAlert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        guard let errorAlert = errorAlert else { return }
        present(errorAlert, animated: true)
    }
    
    
}

