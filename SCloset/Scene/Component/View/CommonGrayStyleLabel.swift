//
//  CommonGrayStyleLabel.swift
//  SCloset
//
//  Created by 이상남 on 12/7/23.
//

import UIKit

class CommonGrayStyleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .boldSystemFont(ofSize: 10)
        self.textColor = .lightGray
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

