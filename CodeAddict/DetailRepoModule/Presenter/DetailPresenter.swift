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
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, repo: Repo?)
    func setRepo()
    func tap()
    var repo: Repo? { get set }
}

class DetailPresenter: DetailViewPresenterProtocol {
    
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var repo: Repo?
    
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
    
}
