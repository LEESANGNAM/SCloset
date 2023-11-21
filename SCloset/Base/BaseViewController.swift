//
//  BaseViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/21/23.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setHierarchy()
        setConstraints()
        // Do any additional setup after loading the view.
    }
    
    
    func setHierarchy(){ }
    func setConstraints(){ }
}
