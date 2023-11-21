//
//  LoginModel.swift
//  SCloset
//
//  Created by 이상남 on 11/21/23.
//

import Foundation

struct LoginRequestModel: Encodable {
    var email: String
    var password: String
}
struct LoginResponseModel: Decodable {
    var token: String
    var refreshToken: String
}
