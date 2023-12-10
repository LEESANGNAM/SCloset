//
//  PostModel.swift
//  SCloset
//
//  Created by 이상남 on 11/26/23.
//

import Foundation

struct PostLoadResponseModel: Decodable {
    let data: [PostLoad]
    let next_cursor: String
}

struct PostLoad: Decodable {
    let likes: [String?]
    let image: [String?]
    let hashTags: [String?]?
    let comments: [Comment?]
    let _id: String
    let creator: Creator
    let time: String?
    let title: String?
    let content: String?
    let content1: String?
    let product_id: String?
    
    var likeCount: Int {
        return likes.count
    }
    var commnetCount: Int {
        return comments.count
    }
}

struct Comment: Decodable {
    let _id: String
    let content: String
    let time: String
    let creator: Creator
}

struct Creator: Decodable {
    let _id: String
    let nick: String
    let profile: String?
}



