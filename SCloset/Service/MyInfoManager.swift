//
//  MyInfoManager.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import Foundation

class MyInfoManager {
    static let shared = MyInfoManager()
    var myinfo: MyProfileModel!
    var posts: [String] = []
    var followerCount = 0
    var followingCount = 0
    private init() { }
    
    func fetch() {
        let myinfo = NetworkManager.shared.request(type: MyProfileModel.self, api: .myInfo)
        myinfo.subscribe(with: self) { owner, value in
            owner.myinfo = value
            owner.posts = value.posts
            owner.followerCount = value.followerCount
            owner.followingCount = value.followingCount
        } onError: { owner, error in
            if let networkError = error as? NetWorkError {
                let errorText = networkError.message()
                print(errorText)
            }
        } onCompleted: { _ in
            print("내정보 가져오기 완료")
        } onDisposed: { _ in
            print("디스포즈")
        }
    }
    
}
