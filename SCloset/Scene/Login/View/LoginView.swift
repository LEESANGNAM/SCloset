//
//  LoginView.swift
//  SCloset
//
//  Created by 이상남 on 11/21/23.
//

import UIKit

class LoginView: BaseView {
    
    let emailLabel = TextfieldTitleLabel(text: "이메일 주소")
    let emailTextField = {
       let view = UITextField()
        view.placeholder = "예) SCloset@closet.com"
        return view
    }()
    
    let passwordLabel = TextfieldTitleLabel(text: "비밀번호")
    
    let passwordTextField = {
       let view = UITextField()
        view.placeholder = "비밀번호를 입력해주세요"
        return view
    }()
    let loginButton = {
       let view = UIButton()
        view.setTitle("로그인", for: .normal)
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    let signUpButton = {
       let view = UIButton()
        view.setTitle("이메일로 회원가입", for: .normal)
        view.backgroundColor = .white
        view.setTitleColor(.systemGray4, for: .normal)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func setHierarchy() {
        addSubview(loginButton)
        addSubview(signUpButton)
        addSubview(passwordTextField)
        addSubview(passwordLabel)
        addSubview(emailTextField)
        addSubview(emailLabel)
    }
    override func setconstraints() {
        setLoginButtonLayout()
        setPasswordLayout()
        setEmailLayout()
    }
    
}

//MARK: setconstraints
extension LoginView {
    private func setLoginButtonLayout(){
        loginButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
        }
    }
    private func setPasswordLayout(){
        passwordTextField.snp.makeConstraints { make in
            make.bottom.equalTo(loginButton.snp.top).offset(-30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        passwordLabel.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
    private func setEmailLayout(){
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordLabel.snp.top).offset(-30)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        emailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
    }
}
