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
        locationLabel.text = "서울시 00동 00/00"
    }
    
    override func setConstraints() {
        lookImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(lookImageView.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        }
    }
}
