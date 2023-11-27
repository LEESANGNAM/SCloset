//
//  PostUploadModel.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import Foundation


struct PostUpLoad: Decodable {
    let likes: [String?]
    let image: [String?]
    let hashTags: [String?]?
    let comments: [String?]?
    let _id: String
    let creator: Creator
    let time: String?
    let title: String?
    let content: String?
    let product_id: String?
}

//struct Comment: Decodable {
//    let _id: String
//    let content: String
//    let time: String
//    let creator: Creator
//}

//struct Creator: Decodable {
//    let _id: String
//    let nick: String
////    let profile: String?
//}
