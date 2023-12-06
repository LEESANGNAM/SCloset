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
        view.image = UIImage(systemName: "person")
        view.layer.cornerRadius = view.frame.width / 2
        view.clipsToBounds = true
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let nicknameLabel = NickNameLabel()
    
    let dateLabel = CommonGrayStyleLabel()
    
    let followButton = {
        let view = UIButton()
        view.backgroundColor = .black
        view.setTitle("팔로우", for: .normal)
        view.setTitleColor(.white, for: .normal)
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
            make.size.equalTo(50)
        }
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(15)
            make.width.equalTo(40)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.top).offset(-10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.size.equalTo(40)
        }
        followButton.snp.makeConstraints { make in
            make.trailing.equalTo(ellipsisButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        
    }
    
    
}

#Preview {
    ProfileView()
}


