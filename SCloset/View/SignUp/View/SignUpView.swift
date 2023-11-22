//
//  SignUpView.swift
//  SCloset
//
//  Created by 이상남 on 11/22/23.
//

import UIKit

class SignUpView: BaseView {
    let emailLabel = TextfieldTitleLabel(text: "이메일주소*")
    let passwordLabel = TextfieldTitleLabel(text: "비밀번호*")
    let nicknameLabel = TextfieldTitleLabel(text: "닉네임*")
    let phoneNumLabel = TextfieldTitleLabel(text: "전화번호")
    let birthDayLabel = TextfieldTitleLabel(text: "생년월일")
    
    let emailTextField = {
       let view = UITextField()
        view.placeholder = "예) SCloset@closet.com"
        return view
    }()
    let emailVaildButton = {
       let view = UIButton()
        view.backgroundColor = .systemGray6
        view.setTitle("이메일 중복확인", for: .normal)
        view.setTitleColor(.systemGray2, for: .normal)
        view.layer.cornerRadius = 10
        view.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        return view
    }()
    let passwordTextField = {
       let view = UITextField()
        view.placeholder = "비밀번호를 입력해주세요"
        return view
    }()
    let nicknameTextField = {
       let view = UITextField()
        view.placeholder = "닉네임을 입력해주세요"
        return view
    }()
    let phoneNumTextField = {
       let view = UITextField()
        view.placeholder = "예) 010-0000-0000"
        return view
    }()
    let birthDayTextField = {
       let view = UITextField()
        view.placeholder = "예) 0000.00.00"
        return view
    }()
    
    let doneButton = {
        let view = UIButton()
         view.setTitle("회원가입", for: .normal)
         view.backgroundColor = .black
         view.setTitleColor(.white, for: .normal)
         view.layer.cornerRadius = 10
         return view
    }()
    
    override func setHierarchy() {
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(emailVaildButton)
        
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
        
        addSubview(phoneNumLabel)
        addSubview(phoneNumTextField)
        
        addSubview(birthDayLabel)
        addSubview(birthDayTextField)
        
        addSubview(doneButton)
    }
    
    override func setconstraints() {
        setEmailLayout()
        setPasswordLayout()
        setNicknameLayout()
        setPhoneNumLayout()
        setBirthDayLayout()
        setDoneButtonLayout()
    }
}

//MARK: setconstraints
extension SignUpView {
    private func setEmailLayout(){
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        emailVaildButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.leading.greaterThanOrEqualTo(emailTextField.snp.trailing).offset(10)
        }
    }
    private func setPasswordLayout(){
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    private func setNicknameLayout(){
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    private func setPhoneNumLayout(){
        phoneNumLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        phoneNumTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    private func setBirthDayLayout(){
        birthDayLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        birthDayTextField.snp.makeConstraints { make in
            make.top.equalTo(birthDayLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setDoneButtonLayout(){
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(birthDayTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    
}
