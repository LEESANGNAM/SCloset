//
//  FollowModel.swift
//  SCloset
//
//  Created by 이상남 on 12/23/23.
//

import Foundation

struct FollowModel: Decodable {
    let user: String
    let following: String
    let following_status: Bool
}
