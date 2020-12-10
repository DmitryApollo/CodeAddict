//
//  RepoPresenter.swift
//  CodeAddict
//
//  Created by Дмитрий on 08/12/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

protocol RepoViewProtocol: class {
    func success()
    func failure(error: Error)
    var page: Int { get set }
}

protocol RepoViewPresenterProtocol : class {
    init(view: RepoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func searchRepo(repoName: String, page: Int, perPage: Int)
    func tapOnRepo(repo: Repo?)
    var repos: [Repo] { get set }
    var totalCount: Int? { get set }
}

class RepoPresenter: RepoViewPresenterProtocol {
    weak var view: RepoViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var repos: [Repo] = []
    var totalCount: Int?
    
    required init(view: RepoViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
    }
    
    func tapOnRepo(repo: Repo?) {
        router?.showDetail(repo: repo)
    }
    
    func searchRepo(repoName: String, page: Int = 1, perPage: Int = 25) {
        networkService.searchRepo(repoName: repoName, page: page, perPage: perPage) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let list):
                    if let list = list {
                        self.totalCount = list.totalCount
                        if self.view?.page == 1 {
                            self.repos = list.items
                        } else {
                            self.repos.append(contentsOf: list.items)
                        }
                    }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
