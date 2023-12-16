//
//  MyInfoViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import Foundation


class MyInfoViewController: BaseViewController {
    
    let mainView = MyInfoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
