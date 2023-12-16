//
//  MyLikePostViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit

class MyLikePostViewController: BaseViewController {
    let test = UILabel()
    
    override func viewDidLoad() {
        test.text = "좋아요 게시글 화면"
        view.addSubview(test)
        view.backgroundColor = .white
        test.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
}
