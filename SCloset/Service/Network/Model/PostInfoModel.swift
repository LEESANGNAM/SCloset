//
//  PostUploadModel.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import Foundation


struct PostInfoModel: Decodable {
    let likes: [String?]
    let image: [String?]
    let hashTags: [String?]
    let comments: [Comment?]
    let _id: String
    let creator: Creator
    let time: String?
    let title: String?
    let content: String?
    let content1: String?
    let product_id: String?
}
