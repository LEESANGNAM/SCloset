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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

