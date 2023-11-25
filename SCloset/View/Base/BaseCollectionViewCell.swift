//
//  BaseCollectionViewCell.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setHierarchy(){ }
    func setConstraints(){ }
}
