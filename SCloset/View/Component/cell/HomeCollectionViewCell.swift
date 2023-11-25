//
//  HomeCollectionViewCell.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import UIKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    let lookImageView = {
            let image = UIImageView()
            image.layer.cornerRadius = 15
            image.layer.masksToBounds = true
        image.backgroundColor = .systemGray
            return image
        }()
        let userNameLabel = {
            let label = UILabel()
            label.text = "Scloset.test1"
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        let likeButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            button.tintColor = .black
            return button
        }()
        let likeCountLabel = {
            let label = UILabel()
            label.text = "999"
            label.numberOfLines = 2
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        let contentLabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "오늘의룩 짜자잔 "
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
    override func setHierarchy() {
        contentView.addSubview(lookImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(contentLabel)
        
    }
    
    override func setConstraints() {
        lookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(lookImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLabel)
            make.leading.equalTo(userNameLabel.snp.trailing).offset(5)
            make.size.equalTo(20)
        }
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
        
        
    }
}
