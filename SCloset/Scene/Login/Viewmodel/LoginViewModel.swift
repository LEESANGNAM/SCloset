//
//  LoginViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/15/23.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    let disposeBag = DisposeBag()
    private var emailText = ""
    private var passwordText = ""
    private var success = PublishRelay<Bool>()
    var errorMessage =  PublishRelay<String>()
    struct Input {
        let emailTextfieldChange: ControlProperty<String>
        let pwTextfieldChange: ControlProperty<String>
        let loginButtonTapped: ControlEvent<Void>
        let signUpButtonTapped: ControlEvent<Void>
    }
    struct Output {
        let loginSuccess: PublishRelay<Bool>
        let errorMessage: PublishRelay<String>
        let signUpButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        input.emailTextfieldChange
            .bind(with: self) { owner, text in
            owner.emailText = text
            }.disposed(by: disposeBag)
        
        input.pwTextfieldChange
            .bind(with: self) { owner, text in
            owner.passwordText = text
            }.disposed(by: disposeBag)
        
        input.loginButtonTapped
            .bind(with: self) { owner, _ in
                owner.testRequest()
            }.disposed(by: disposeBag)
        
        return Output(loginSuccess: success,errorMessage: errorMessage, signUpButtonTapped: input.signUpButtonTapped)
    }
    
    private func setToken(token: String, refesh: String) {
        UserDefaultsManager.token = token
        UserDefaultsManager.refresh = refesh
    }
    private func setIsLogin() {
        UserDefaultsManager.isLogin = true
    }
    private func testRequest() {
        let testLoginModel = LoginRequestModel(email: emailText, password: passwordText) // 입력창에서 받아와서 객체생성 

        let test = NetworkManager.shared.request(type: LoginResponseModel.self, api: .login(testLoginModel))
        test.subscribe(with: self) { owner, value in
            owner.success.accept(true)
            owner.setToken(token: value.token, refesh: value.refreshToken)
            owner.setIsLogin()
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errorText = testErrorType.message()
                owner.errorMessage.accept(errorText)
                owner.success.accept(false)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)

    }
}
