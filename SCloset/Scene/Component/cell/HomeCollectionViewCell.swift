//
//  HomeCollectionViewCell.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: BaseCollectionViewCell {
    let lookImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.backgroundColor = .systemGray
        return image
    }()
    let userProfileImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.backgroundColor = .systemGray5
        image.tintColor = .lightGray
        image.layer.masksToBounds = true
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
    let contentLabel = CommonGrayStyleLabel()
    
    override func setHierarchy() {
        contentView.addSubview(lookImageView)
        contentView.addSubview(userProfileImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(likeButton)
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        
    }
    
    override func setConstraints() {
        lookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        userProfileImageView.snp.makeConstraints { make in
            make.top.equalTo(lookImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.size.equalTo(20)
        }
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(lookImageView.snp.bottom).offset(5)
            make.leading.equalTo(userProfileImageView.snp.trailing).offset(5)
            make.height.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(userNameLabel)
            make.leading.greaterThanOrEqualTo(userNameLabel.snp.trailing).offset(5)
            make.size.equalTo(20)
        }
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
        
        
    }
    func setData(data: PostLoad){
        if let locationContent = data.content1 {
            contentLabel.text = locationContent
        }
        let username = data.creator.nick
        userNameLabel.text = username
        setImage(data: data)
        likeCountLabel.text = "\(data.likeCount)"
        var heartImage: UIImage
        let islike = data.likes.contains(UserDefaultsManager.id)
        if islike {
            heartImage = UIImage(systemName: "heart.fill")!
        }else {
            heartImage = UIImage(systemName: "heart")!
        }
        likeButton.setImage(heartImage, for: .normal)
        
    }
    
    private func setImage(data: PostLoad) {
        layoutIfNeeded()
        if let imageBase = data.image.first,
           let imageBase {
            let urlString = APIKey.baseURL + imageBase
            let imageSize = lookImageView.frame.size
            lookImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "photo.fill")
        }
        if let profileBase = data.creator.profile {
            let urlString = APIKey.baseURL + profileBase
            let imageSize = userProfileImageView.frame.size
            userProfileImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "person.fill")
        } else {
            userProfileImageView.image = UIImage(systemName: "person.fill")
        }
    }
}
