//
//  StyleAddView.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import UIKit

class StyleAddView: BaseView {
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let contentView = UIView()
    lazy var contentList: [UIView] = [lookImageView,plusImageView,titleTextField,locationLabel,contentTextView]
    
    let lookImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        view.contentMode = .scaleToFill
        return view
    }()
    let plusImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "plus")
        view.tintColor = .systemGray
        return view
    }()
    let titleTextField = {
        let view = UITextField()
        view.placeholder = "제목을 입력해주세요~"
        return view
    }()
    let locationLabel = {
      let view = UILabel()
        view.text = "위치: 날씨/날씨"
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 14)
        return view
    }()
    let contentTextView = {
        let view = UITextView()
        view.text = "자ㅏ라라라라라라랜요오옹오오내요요요오오옹내요요요요오오옹"
        return view
    }()
    
    override func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentList.forEach { contentView.addSubview($0) }
    }
    override func setconstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView)
        }
        
        lookImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.6)
        }
        plusImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.centerX.equalTo(lookImageView.snp.centerX)
            make.centerY.equalTo(lookImageView.snp.centerY)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(lookImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.9)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        
        
    }
    
}

