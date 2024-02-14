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
        view.tintColor = .lightGray
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
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
//        addSubview(doneButton)
        commentTextField.addLeftPadding()
        doneButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) 
        commentTextField.rightView = doneButton
        commentTextField.rightViewMode = .always
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
        
    }
    
    func setProfile() {
        if let profileBase = MyInfoManager.shared.myinfo?.profile {
            let urlString = APIKey.baseURL + profileBase
            let imageSize = profileIamgeView.frame.size
            profileIamgeView.setImage(with: urlString, frameSize: imageSize, placeHolder: "person.fill")
        } else {
            profileIamgeView.image = UIImage(systemName: "person.fill")
        }
    }
    
}
