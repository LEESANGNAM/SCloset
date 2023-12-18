//
//  ProfileEditView.swift
//  SCloset
//
//  Created by 이상남 on 12/18/23.
//

import UIKit


class ProfileEditView: BaseView {
    let profileImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person.fill")
        view.backgroundColor = .systemGray5
        view.tintColor = .lightGray
        return view
    }()
    
    let nicknameLabel = TextfieldTitleLabel(text: "닉네임")
    let nicknameTextField = {
       let view = UITextField()
        view.placeholder = "닉네임 입력해주세요"
        return view
    }()
    
    let phoneNumLabel = TextfieldTitleLabel(text: "전화번호")
    let phoneNumTextField = {
       let view = UITextField()
        view.placeholder = "전화번호를 입력해주세요"
        return view
    }()
    
    let birthdayLabel = TextfieldTitleLabel(text: "생일")
    let birthdayTextField = {
       let view = UITextField()
        view.placeholder = "생일을 입력해주세요"
        return view
    }()
    
    override func setHierarchy() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
        addSubview(phoneNumLabel)
        addSubview(phoneNumTextField)
        addSubview(birthdayLabel)
        addSubview(birthdayTextField)
    }
    
    override func setconstraints() {
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(profileImageView.snp.width)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        phoneNumLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        phoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        birthdayTextField.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
    }
    
    
    
    
}
