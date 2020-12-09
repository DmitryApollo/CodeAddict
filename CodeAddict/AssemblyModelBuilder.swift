//
//  ModelBuilder.swift
//  MVPTest
//
//  Created by Дмитрий on 30/11/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createRepoModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(repo: Repo?, router: RouterProtocol) -> UIViewController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
    func createRepoModule(router: RouterProtocol) -> UIViewController {
        let view = RepoViewController()
        let networkService = NetworkService()
        let presenter = RepoPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(repo: Repo?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, repo: repo)
        view.presenter = presenter
        return view
    }
}
