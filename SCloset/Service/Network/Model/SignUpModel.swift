//
//  SignUpModel.swift
//  SCloset
//
//  Created by 이상남 on 11/21/23.
//

import Foundation

struct SignUpRequestModel: Encodable {
    var email: String
    var password: String
    var nick: String
    var phoneNum: String?
    var birthDay: String?
}
struct SignUpResponeModel: Decodable {
    var _id: String
    var email: String
    var nick: String
}
