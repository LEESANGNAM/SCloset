//
//  SignUpViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/22/23.
//

import UIKit
import Toast
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {
    let disposeBag = DisposeBag()
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    private func bind(){
        let input = SignUpViewModel.Input(
            emailTextfieldChange: mainView.emailTextField.rx.text.orEmpty,
            passwordTextfieldChange: mainView.passwordTextField.rx.text.orEmpty,
            nicknameTextfieldChange: mainView.nicknameTextField.rx.text.orEmpty,
            phoneNumTextfieldChange: mainView.phoneNumTextField.rx.text.orEmpty,
            birthDayTextfieldChange: mainView.birthDayTextField.rx.text.orEmpty,
            emailCheckButtonTap: mainView.emailVaildButton.rx.tap,
            doneButtonTapped: mainView.doneButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.message
            .bind(with: self) { owner, massage in
                owner.view.makeToast(massage, position: .top)
            }.disposed(by: disposeBag)
        
        output.emailCheck
            .bind(with: self) { owner, valid in
                owner.mainView.doneButton.isEnabled = valid
                owner.mainView.doneButton.backgroundColor = valid ? .black : .gray
            }.disposed(by: disposeBag)
        
        output.signUpCheck
            .bind(with: self) { owner, valid in
                if valid {
                    owner.dismiss(animated: true)
                }
            }.disposed(by: disposeBag)
        
        
    }

}
