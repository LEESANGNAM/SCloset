//
//  NickNameLabel.swift
//  SCloset
//
//  Created by 이상남 on 12/7/23.
//

import UIKit


class NickNameLabel:  UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .boldSystemFont(ofSize: 14)
        self.textColor = .black
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
