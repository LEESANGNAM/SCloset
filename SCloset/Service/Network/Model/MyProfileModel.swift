//
//  MyProfileResponseModel.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import Foundation

struct MyProfileModel: Decodable {
    let posts: [String]
    let followers: [Creator]
    let following: [Creator]
    let _id: String
    let email: String
    let nick: String
    let phoneNum: String
    let birthDay: String
    let profile: String?
}
