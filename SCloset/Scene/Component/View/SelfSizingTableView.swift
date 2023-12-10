//
//  SelfSizingTableView.swift
//  SCloset
//
//  Created by 이상남 on 12/11/23.
//

import UIKit


class SelfSizingTableView: UITableView {
  override var intrinsicContentSize: CGSize {
    contentSize
  }
  
  override func layoutSubviews() {
    invalidateIntrinsicContentSize()
    super.layoutSubviews()
  }
}
