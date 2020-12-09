//
//  DetailViewController.swift
//  MVPTest
//
//  Created by Дмитрий on 01/12/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var commentLabel: UILabel!
    
    var presenter: DetailViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        presenter.tap()
    }
    
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        commentLabel.text = comment?.body
    }
    
    
}
