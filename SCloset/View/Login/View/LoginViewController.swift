//
//  ViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/15/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Toast

class LoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    let mainView = LoginView()
    let viewModel = LoginViewModel()
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        // Do any additional setup after loading the view.
    }
    private func bind(){
        let input = LoginViewModel.Input(emailTextfieldChange: mainView.emailTextField.rx.text.orEmpty, pwTextfieldChange: mainView.passwordTextField.rx.text.orEmpty, loginButtonTapped: mainView.loginButton.rx.tap, signUpButtonTapped: mainView.signUpButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.loginSuccess
            .bind(with: self) { owner, value in
                if value {
                    owner.changeRootView()
                }
            }.disposed(by: disposeBag)
        
        output.errorMessage
            .bind(with: self) { owner, errorText in
                owner.view.makeToast(errorText, position: .top)
            }.disposed(by: disposeBag)
        
        output.signUpButtonTapped
            .bind(with: self) { owner, _ in
                owner.present(SignUpViewController(), animated: true)
            }.disposed(by: disposeBag)
        
    }
    
    private func changeRootView(){
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = TabbarController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
    }

}

