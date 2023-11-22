//
//  SignUpViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/22/23.
//

import Foundation

class SignUpViewController: BaseViewController {
    
    let mainView = SignUpView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
