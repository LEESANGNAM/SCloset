//
//  BaseView.swift
//  SCloset
//
//  Created by 이상남 on 11/21/23.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setHierarchy()
        setconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setconstraints() { }
    func setHierarchy() { }
    
}
