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
    struct Input {
        let emailTextfieldChange: ControlProperty<String>
        let pwTextfieldChange: ControlProperty<String>
        let loginButtonTapped: ControlEvent<Void>
    }
    struct Output {
        let loginSuccess: PublishRelay<Bool>
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
                print("탭 되고있음")
            }.disposed(by: disposeBag)
        
        return Output(loginSuccess: success)
    }
    
    private func testRequest() {
        let testLoginModel = LoginRequestModel(email: emailText, password: passwordText) // 입력창에서 받아와서 객체생성 

        let test = NetworkManager.shared.request(type: LoginResponseModel.self, api: .login(testLoginModel))
        test.subscribe(with: self) { owner, value in
           let text = "토큰값 : \(value.token) \n ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 리프레시 토큰값 \(value.refreshToken) 유저디폴트에 저장"
            print("로그인 성공")
            owner.success.accept(true)
            print(text)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                switch testErrorType {
                    case let .notKey(statusCode, message),
                         let .overcall(statusCode, message),
                         let .requestPathError(statusCode, message),
                         let .missingParameter(statusCode, message),
                         let .notUser(statusCode, message),
                         let .invalidServerError(statusCode, message):
                        print( "오류코드: \(statusCode) 메세지: \(message) 토스트메세지 띄움" )
                    }
                owner.success.accept(false)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)

    }
}
