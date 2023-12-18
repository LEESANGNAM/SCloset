//
//  ProfileEditViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/18/23.
//

import Foundation

class ProfileEditViewController: BaseViewController {
    
    let mainView = ProfileEditView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
