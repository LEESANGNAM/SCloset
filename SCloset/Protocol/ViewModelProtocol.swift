//
//  ViewmodelProtocol.swift
//  SCloset
//
//  Created by 이상남 on 12/10/23.
//

import Foundation

protocol ViewModelProtocol: AnyObject {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
