//
//  PostImageCollectionViewCell.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import UIKit

class PostImageCollectionViewCell: BaseCollectionViewCell {
    let lookImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.backgroundColor = .systemGray
        return image
    }()
    let locationLabel = CommonGrayStyleLabel()
    
    override func setHierarchy() {
        contentView.addSubview(lookImageView)
        contentView.addSubview(locationLabel)
        locationLabel.numberOfLines = 0
    }
    
    override func setConstraints() {
        lookImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(lookImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    func setData(_ data: PostInfoModel) {
        setImage(data: data)
        locationLabel.text = data.content1
    }
    private func setImage(data: PostInfoModel) {
        layoutIfNeeded()
        if let imageBase = data.image.first,
           let imageBase {
            let urlString = APIKey.baseURL + imageBase
            let imageSize = lookImageView.frame.size
            lookImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "photo.fill")
        }
    }
}
