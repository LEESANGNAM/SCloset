//
//  StyleViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import UIKit

class StyleAddViewController: BaseViewController {
    let mainView = StyleAddView()
    let viewModel = StyleAddViewModel()
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
