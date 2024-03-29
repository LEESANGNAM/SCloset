//
//  ProfileView.swift
//  SCloset
//
//  Created by 이상남 on 12/7/23.
//

import UIKit

class ProfileView: BaseView {
    
    let profileImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGray5
        view.tintColor = .lightGray
        return view
    }()
    
    let nicknameLabel = NickNameLabel()
    
    let dateLabel = CommonGrayStyleLabel()
    
    let followButton = {
        let view = UIButton()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let ellipsisButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        view.tintColor = .black
        view.backgroundColor = .white
        return view
    }()
    
    override func setHierarchy() {
        addSubview(profileImageView)
        addSubview(dateLabel)
        addSubview(nicknameLabel)
        addSubview(ellipsisButton)
        addSubview(followButton)
    }
    override func setconstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(40)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(15)
            make.trailing.lessThanOrEqualTo(ellipsisButton.snp.leading).offset(-10)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(20)
            make.trailing.lessThanOrEqualTo(followButton.snp.leading).offset(-5)
        }
        ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.size.equalTo(20)
        }
        followButton.snp.makeConstraints { make in
            make.trailing.equalTo(ellipsisButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
    }
    func setData(corner: CGFloat,data: PostInfoModel ) {
        setImage(data: data)
        profileImageView.layer.cornerRadius = corner
        dateLabel.text = data.relativeDate
    }
    private func setImage(data: PostInfoModel) {
        layoutIfNeeded()
        if let imageBase = data.creator.profile {
            let urlString = APIKey.baseURL +  imageBase
            let imageSize = profileImageView.frame.size
            profileImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "person.fill")
        } else {
            profileImageView.image = UIImage(systemName: "person.fill")
        }
    }
    
}


