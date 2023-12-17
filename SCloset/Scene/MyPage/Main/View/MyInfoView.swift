//
//  MyInfoView.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit


class MyInfoView: BaseView {
    let profileImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        view.tintColor = .lightGray
        return view
    }()
    let emailLabel = {
        let view = UILabel()
        view.text = "eamil@naver.com"
        return view
    }()
    let nicknameLabel = {
        let view = UILabel()
        view.text = "nickname"
        view.font = .boldSystemFont(ofSize: 18)
        return view
    }()
    let followerLabel = {
        let view = UILabel()
        view.isUserInteractionEnabled = true
        view.text = "팔로워 -"
        return view
    }()
    let followingLabel = {
        let view = UILabel()
        view.isUserInteractionEnabled = true
        view.text = "팔로잉 -"
        return view
    }()
    let profileEditButton = {
        let view = UIButton()
        view.setTitle("프로필 관리", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray6.cgColor
        return view
    }()
    let profileSharedButton = {
        let view = UIButton()
        view.setTitle("프로필 공유", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray6.cgColor
        return view
    }()
    
    let tabmanView = UIView()
    let tabmanVC = TabManViewController()
    
    
    override func setHierarchy() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(followerLabel)
        addSubview(followingLabel)
        
        addSubview(emailLabel)
        
        addSubview(profileEditButton)
        addSubview(profileSharedButton)
        
        addSubview(tabmanView)
        tabmanView.addSubview(tabmanVC.view)
        
    }
    
    override func setconstraints() {
        profileImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(profileImageView.snp.width)
            make.leading.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).offset(-10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
        followerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).offset(10)
            make.leading.equalTo(nicknameLabel.snp.leading)
        }
        followingLabel.snp.makeConstraints { make in
            make.top.equalTo(followerLabel.snp.top)
            make.leading.equalTo(followerLabel.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide).offset(-30)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
        }
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(40)
        }
        profileSharedButton.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton.snp.top)
            make.leading.equalTo(profileEditButton.snp.trailing).offset(5)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.width.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.43)
            make.height.equalTo(40)
        }
        tabmanView.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        tabmanVC.view.snp.makeConstraints { make in
              make.top.equalToSuperview()
              make.horizontalEdges.bottom.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    
    
    
    
}
