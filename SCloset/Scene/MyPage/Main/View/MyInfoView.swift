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
    let logOutButton = {
        let view = UIButton()
        view.setTitle("로그아웃", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray6.cgColor
        return view
    }()
    let outerScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    let contentView = UIView()
    
    let myProfileInfoView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let tabmanView = UIView()
    let tabmanVC = TabManViewController()
    
    var innerScrollView: UIScrollView? {
        if let currentTabmanMyPostVC = tabmanVC.currentViewController as? MyPostViewController {
            return currentTabmanMyPostVC.collectionView
        } else if let currentTabmanMyLikePostVC = tabmanVC.currentViewController as? MyLikePostViewController{
            return currentTabmanMyLikePostVC.collectionView
        } else {
            return nil
        }
    }
    
    override func setHierarchy() {
        addSubview(outerScrollView)
        contentView.backgroundColor = .blue
        outerScrollView.addSubview(contentView)
        contentView.addSubview(myProfileInfoView)
    
        myProfileInfoView.addSubview(profileImageView)
        myProfileInfoView.addSubview(nicknameLabel)
        myProfileInfoView.addSubview(followerLabel)
        myProfileInfoView.addSubview(followingLabel)
        
        myProfileInfoView.addSubview(emailLabel)
        
        myProfileInfoView.addSubview(profileEditButton)
        myProfileInfoView.addSubview(logOutButton)
        
        
        contentView.addSubview(tabmanView)
        tabmanView.addSubview(tabmanVC.view)
        
    }
    
    override func setconstraints() {
        outerScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(outerScrollView)
            make.height.equalToSuperview()
        }
        myProfileInfoView.snp.makeConstraints { make in
            make.width.equalTo(contentView)
            make.top.equalTo(contentView.snp.top)
        }
        profileImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(profileImageView.snp.width)
            make.leading.equalTo(myProfileInfoView.snp.leading).offset(20)
            make.top.equalTo(myProfileInfoView.snp.top).offset(20)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).offset(-10)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
            make.trailing.equalTo(myProfileInfoView.snp.trailing).offset(-20)
        }
        followerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView).offset(10)
            make.leading.equalTo(nicknameLabel.snp.leading)
        }
        followingLabel.snp.makeConstraints { make in
            make.top.equalTo(followerLabel.snp.top)
            make.leading.equalTo(followerLabel.snp.trailing).offset(10)
            make.trailing.lessThanOrEqualTo(myProfileInfoView.snp.trailing).offset(-30)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(myProfileInfoView).inset(20)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
        }
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(0.43)
            make.bottom.equalTo(myProfileInfoView.snp.bottom).offset(-10)
            make.height.equalTo(40)
        }
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton.snp.top)
            make.leading.equalTo(profileEditButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalToSuperview().multipliedBy(0.43)
            make.bottom.equalTo(myProfileInfoView.snp.bottom).offset(-10)
            make.height.equalTo(40)
        }
        
        tabmanView.snp.makeConstraints { make in
            make.top.equalTo(myProfileInfoView.snp.bottom)
            make.width.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        tabmanVC.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
    }
    
    
    
    
    
}
