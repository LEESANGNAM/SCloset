//
//  MyInfoManager.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import Foundation
import RxSwift

class MyInfoManager {
    static let shared = MyInfoManager()
    private let disposeBag = DisposeBag()
    var myinfo: MyProfileModel?
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
        }.disposed(by: disposeBag)
    }
    
    func updateData(profile: MyProfileModel){
        myinfo = profile
        posts = profile.posts
        followerCount = profile.followerCount
        followingCount = profile.followingCount
    }
    func myComment(commentCratorId: String?) -> Bool {
        guard let myinfo else { return false }
        guard let commentCratorId else { return false }
        if myinfo._id == commentCratorId {
            return true
        } else {
            return false
        }
    }
    func mypost(postId: String) -> Bool {
        guard let myinfo else { return false }
        return myinfo.posts.contains(postId)
    }
    func isFollowingUser(userId: String) -> Bool {
        guard let myinfo else { return false }
        let isFollowing = myinfo.following.contains { creator in
            creator._id == userId
        }
        return isFollowing
    }
    
}
