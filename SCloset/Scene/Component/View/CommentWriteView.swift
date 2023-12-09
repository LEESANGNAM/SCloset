//
//  CommentWriteView.swift
//  SCloset
//
//  Created by 이상남 on 12/9/23.
//

import UIKit

class CommentWriteView: BaseView {
    
    let profileIamgeView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    let commentTextField = {
        let view = UITextField()
        view.placeholder = "댓글을 남기세요..."
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 20
        return view
    }()
    
    let doneButton = {
        let view = UIButton()
        view.setTitle("등록", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .clear
        return view
    }()
    
    override func setHierarchy() {
        addSubview(profileIamgeView)
        addSubview(commentTextField)
        addSubview(doneButton)
    }
    
    override func setconstraints() {
        profileIamgeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(40)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileIamgeView.snp.trailing).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(40)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextField)
            make.trailing.equalTo(commentTextField.snp.trailing).offset(-10)
            make.height.equalTo(commentTextField.snp.height)
            make.size.equalTo(40)
        }
        
    }
    
}
