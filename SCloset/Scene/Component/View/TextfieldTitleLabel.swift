//
//  TextfieldTitleLabel.swift
//  SCloset
//
//  Created by 이상남 on 11/22/23.
//

import UIKit

class TextfieldTitleLabel: UILabel {
    
    init(text: String){
        super.init(frame: .zero)
        self.font = .boldSystemFont(ofSize: 10)
        self.textColor = .black
        self.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
