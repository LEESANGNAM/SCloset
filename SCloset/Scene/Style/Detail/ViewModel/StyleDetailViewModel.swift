//
//  StyleDetailViewModel.swift
//  SCloset
//
//  Created by 이상남 on 12/9/23.
//

import Foundation
import RxCocoa
import RxSwift

class StyleDetailViewModel: ViewModelProtocol {
    
    var postData = BehaviorRelay<PostInfoModel?>(value: nil)
    let disposeBag = DisposeBag()
    var item = BehaviorRelay<[Comment?]>(value: [])
    var commentText = ""
    let isLike = BehaviorRelay(value: false)
    let isCommentValid = BehaviorRelay(value: true) // button ishidden
    let searchSuccess = BehaviorRelay(value: false)
    struct Input {
        let viewWillAppear: Observable<Void>
        let followButtonTapped: ControlEvent<Void>
        let ellipsisButtonTapped: ControlEvent<Void>
        let likeButtonTapped: ControlEvent<Void>
        let commentButtonTapped: ControlEvent<Void>
        let commentWriteTextFieldChange: ControlProperty<String>
        let commentDoneButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let searchSuccess: BehaviorRelay<Bool>
        let ellipsisButtonTapped: ControlEvent<Void>
        let isLike: BehaviorRelay<Bool>
//        let followResult: PublishRelay<Bool>
        let isCommentValid: BehaviorRelay<Bool>
        let commentButtonTapped: ControlEvent<Void>
        let commentDoneButtonTapped: ControlEvent<Void>
        var item: BehaviorRelay<[Comment?]>
    }
    
    func transform(input: Input) -> Output{
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.postSearch()
                owner.isLikeValid()
            }.disposed(by: disposeBag)
        input.likeButtonTapped
            .bind(with: self) { owner, _ in
                owner.likeButtonTapped()
            }.disposed(by: disposeBag)
        
        input.commentWriteTextFieldChange
            .bind(with: self) { owner, value in
                owner.commentText = value
                owner.CommentValid()
            }.disposed(by: disposeBag)
        
        input.commentDoneButtonTapped
            .bind(with: self) { owner, _ in
                owner.writeCommnet()
            }.disposed(by: disposeBag)
        
        return Output(searchSuccess: searchSuccess, ellipsisButtonTapped: input.ellipsisButtonTapped, isLike: isLike, isCommentValid: isCommentValid, commentButtonTapped: input.commentButtonTapped, commentDoneButtonTapped: input.commentDoneButtonTapped, item: item)
    }
    
    func getcommnetsCount() -> Int{
        return item.value.count
    }
    func getcommnet(_ index: Int) -> Comment?{
        return item.value[index]
    }
    
    func getPost() -> PostInfoModel? {
        return postData.value
    }
    func isLikeValid(){
        if let post = getPost() {
            let like = post.likes.contains(UserDefaultsManager.id)
            isLike.accept(like)
        }
    }
    func CommentValid() {
        if commentText.isEmpty {
            isCommentValid.accept(true)
        } else if commentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            isCommentValid.accept(true)
        } else {
            isCommentValid.accept(false)
        }
    }
    func writeCommnet(){
        guard let postData = postData.value else { return }
        
        let comment = NetworkManager.shared.request(type: Comment.self, api: .writeComment(postId: postData._id, comment: commnetRequestModel(content: commentText)))
        comment.subscribe(with: self) { owner, data in
            print("댓글작성~~")
            print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
            print(data)
        } onError: { owner, error in
            if let error = error as? NetWorkError {
                let errorText = error.message()
                print(errorText)
            }
        } onCompleted: { owner in
            owner.postSearch()
        } onDisposed: { _ in
            print("디스포즈")
        }.disposed(by: disposeBag)
    }
    
    func postSearch() {
        guard let postData = postData.value else { return }
        let postInfo = NetworkManager.shared.request(type: PostInfoModel.self, api: .postSearch(postId: postData._id))
        postInfo.subscribe(with: self) { owner, value in
            print("포스트 한개 조회")
            print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
            print(value)
            owner.item.accept(value.comments)
            owner.postData.accept(value)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errortext = testErrorType.message()
                print(errortext)
            }
        } onCompleted: { owner in
            owner.searchSuccess.accept(true)
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)
    }
    
    func likeButtonTapped() {
        guard let postData = postData.value else { return }
        let like = NetworkManager.shared.request(type: PostLikeModel.self, api: .postLike(postId: postData._id))
        
        like.subscribe(with: self) { owner, model in
            let like = model.like_status
            owner.isLike.accept(like)
        } onError: { owner, error in
            if let error = error as? NetWorkError {
                let errorText = error.message()
                print(errorText)
            }
        } onCompleted: { owner in
            owner.postSearch()
        } onDisposed: { _ in
            print("디스포즈")
        }.disposed(by: disposeBag)
    }
    
}
