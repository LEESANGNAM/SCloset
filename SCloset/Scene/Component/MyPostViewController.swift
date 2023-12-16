//
//  MyPostViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit

class MyPostViewController: BaseViewController {
    let test = UILabel()
    
    override func viewDidLoad() {
        test.text = "나의 게시글 화면"
        view.addSubview(test)
        view.backgroundColor = .white
        test.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
}
