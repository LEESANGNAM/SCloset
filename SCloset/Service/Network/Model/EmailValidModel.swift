//
//  EmailValidModel.swift
//  SCloset
//
//  Created by 이상남 on 11/23/23.
//

import Foundation

struct EmailValidRequestModel: Encodable{
    let email: String
}
struct EmailValidResponeModel: Decodable{
    let message: String
}
