//
//  StyleDetailViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/7/23.
//

import Foundation

class StyleDetailViewController: BaseViewController {
    
    let mainView = StyleDetailView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "게시물"
    }
    
}
