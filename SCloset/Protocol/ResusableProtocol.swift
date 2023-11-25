//
//  any.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import Foundation
protocol ResusableProtocol {
    static var identifier: String { get }
}

extension NSObject: ResusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
