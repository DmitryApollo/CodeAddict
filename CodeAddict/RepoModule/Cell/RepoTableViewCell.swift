//
//  RepoTableViewCell.swift
//  CodeAddict
//
//  Created by Дмитрий on 09/12/2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

import UIKit
import SnapKit

class RepoTableViewCell: UITableViewCell {
    
    let mainView = UIView()
    let userImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(mainView)
        mainView.layer.cornerRadius = 10
        mainView.backgroundColor = .systemGray6
        mainView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview().offset(5)
            maker.bottom.equalToSuperview().offset(-5)
            maker.leading.equalToSuperview().offset(8)
            maker.trailing.equalToSuperview().offset(-8)
        }
        
        mainView.addSubview(userImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(subtitleLabel)
        
        userImageView.layer.cornerRadius = 10
        userImageView.clipsToBounds = true
        
        userImageView.snp.makeConstraints { (maker) in
            maker.width.equalTo(50)
            maker.height.equalTo(50)
            maker.leading.equalToSuperview().offset(8)
            maker.centerY.equalToSuperview()
        }
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.lineBreakMode = .byTruncatingTail
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(66)
            maker.trailing.equalToSuperview().offset(8)
            maker.centerY.equalToSuperview().offset(-10)
        }
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        
        subtitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalToSuperview().offset(60)
            maker.trailing.equalToSuperview().offset(8)
            maker.centerY.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
    }
}
