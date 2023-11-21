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
        let input = LoginViewModel.Input(emailTextfieldChange: mainView.emailTextField.rx.text.orEmpty, pwTextfieldChange: mainView.passwordTextField.rx.text.orEmpty, loginButtonTapped: mainView.loginButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.loginSuccess
            .bind(with: self) { owner, value in
                owner.mainView.loginButton.setTitle(value ? "성공": "실패", for: .normal)
            }.disposed(by: disposeBag)
        
    }
    

}

