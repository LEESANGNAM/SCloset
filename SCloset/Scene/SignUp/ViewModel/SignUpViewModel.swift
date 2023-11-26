//
//  SignUpViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/23/23.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel {
    let disposeBag = DisposeBag()
    private var emailText = ""
    private var passwordText = ""
    private var nicknameText = ""
    private var phoneNumText = ""
    private var birthDayText = ""
    private var emailCheck = BehaviorRelay<Bool>(value: false)
    private var signUpCheck = PublishRelay<Bool>()
    private var message =  PublishRelay<String>()
    
    struct Input {
        let emailTextfieldChange: ControlProperty<String>
        let passwordTextfieldChange: ControlProperty<String>
        let nicknameTextfieldChange: ControlProperty<String>
        let phoneNumTextfieldChange: ControlProperty<String>
        let birthDayTextfieldChange: ControlProperty<String>
        let emailCheckButtonTap: ControlEvent<Void>
        let doneButtonTapped: ControlEvent<Void>
    }
    struct Output {
        var emailCheck: BehaviorRelay<Bool>
        var signUpCheck: PublishRelay<Bool>
        var message: PublishRelay<String>
    }
    
    func transform(input: Input) -> Output {
        input.emailTextfieldChange
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                owner.emailText = text
                owner.emailCheck.accept(false)
            }.disposed(by: disposeBag)
        
        input.passwordTextfieldChange
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                owner.passwordText = text
            }.disposed(by: disposeBag)
        
        input.nicknameTextfieldChange
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                owner.nicknameText = text
            }.disposed(by: disposeBag)
        
        input.phoneNumTextfieldChange
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                owner.phoneNumText = text
            }.disposed(by: disposeBag)
        
        input.birthDayTextfieldChange
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                owner.birthDayText = text
            }.disposed(by: disposeBag)
        
        
        
        input.emailCheckButtonTap
            .bind(with: self) { owner, _ in
                owner.checkEmailVaild()
            }.disposed(by: disposeBag)
        
        
        
        input.doneButtonTapped
            .bind(with: self) { owner, _ in
                if owner.emailCheck.value{
                    owner.SignUpRequest()
                } else {
                    owner.message.accept("이메일 중복 체크를 해주세요")
                }
            }.disposed(by: disposeBag)
        
        
        return Output(emailCheck: emailCheck, signUpCheck: signUpCheck, message: message)
    }
    
    private func saveNickName(_ name: String) {
        UserDefaultsManager.nickname = name
    }
    
    private func checkEmailVaild() {
        let emailRequest = EmailValidRequestModel(email: emailText)
        
        let emailResponse = NetworkManager.shared.request(type: EmailValidResponeModel.self, api: .emailVlidation(emailRequest))
        
        emailResponse.subscribe(with: self) { owner, value in
            owner.message.accept(value.message)
            owner.emailCheck.accept(true)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                switch testErrorType {
                case let .notKey(statusCode, message),
                    let .overcall(statusCode, message),
                    let .requestPathError(statusCode, message),
                    let .missingParameter(statusCode, message),
                    let .notUser(statusCode, message),
                    let .invalidServerError(statusCode, message):
                    
                    let text = "오류코드 \(statusCode): \(message) "
                    owner.message.accept(text)
                }
                owner.emailCheck.accept(false)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)

            
    }
    
    
     private func SignUpRequest() {
        let joinRequestModel = SignUpRequestModel(email: emailText, password: passwordText, nick: nicknameText, phoneNum: phoneNumText, birthDay: birthDayText)

        let joinResponse = NetworkManager.shared.request(type: SignUpResponeModel.self, api: .join(joinRequestModel))
         joinResponse.subscribe(with: self) { owner, value in
             owner.saveNickName(value.nick)
             owner.signUpCheck.accept(true)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                switch testErrorType {
                    case let .notKey(statusCode, message),
                         let .overcall(statusCode, message),
                         let .requestPathError(statusCode, message),
                         let .missingParameter(statusCode, message),
                         let .notUser(statusCode, message),
                         let .invalidServerError(statusCode, message):
                         let text = "오류코드 \(statusCode): \(message) "
                    owner.message.accept(text)
                    
                    }
                owner.signUpCheck.accept(false)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)

    }
    
}
