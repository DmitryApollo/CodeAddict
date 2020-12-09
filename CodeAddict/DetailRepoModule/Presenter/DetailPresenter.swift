//
//  DetailPresenter.swift
//  MVPTest
//
//  Created by Дмитрий on 09/12/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func setRepo(repo: Repo?)
    func success()
    func failure(error: Error)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, repo: Repo?)
    func getCommits(owner: String, repoTitle: String)
    func setRepo()
    func tap()
    var repo: Repo? { get set }
    var commits: [Commit] { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var repo: Repo?
    var commits: [Commit] = []
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, repo: Repo?) {
        self.view = view
        self.networkService = networkService
        self.repo = repo
        self.router = router
    }
    
    func tap() {
        router?.popToRoot()
    }
    
    func setRepo() {
        self.view?.setRepo(repo: repo)
    }
    
    func getCommits(owner: String, repoTitle: String) {
        networkService.getCommits(owner: owner, repoTitle: repoTitle) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let array):
                    if var array = array {
                        if array.count > 3 {
                            array.removeSubrange(3...array.count - 1)
                        }
                        self.commits = array
                    }
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
}
