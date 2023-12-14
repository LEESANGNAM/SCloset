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
    var item: [String] = ["테스트1","테스트2"]
    let isLike = BehaviorRelay(value: false)
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
        let viewWillAppear: Observable<Void>
        let ellipsisButtonTapped: ControlEvent<Void>
        let isLike: BehaviorRelay<Bool>
//        let followResult: PublishRelay<Bool>
        let commentButtonTapped: ControlEvent<Void>
        let commentDoneButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output{
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.postSearch()
                owner.isLikeVaild()
            }.disposed(by: disposeBag)
        input.likeButtonTapped
            .bind(with: self) { owner, _ in
                owner.likeButtonTapped()
            }.disposed(by: disposeBag)
        
        return Output(viewWillAppear: input.viewWillAppear, ellipsisButtonTapped: input.ellipsisButtonTapped, isLike: isLike, commentButtonTapped: input.commentButtonTapped, commentDoneButtonTapped: input.commentDoneButtonTapped)
    }
    
    func additem() {
        item.append("테스트\(Int.random(in: 1...500))")
    }
    
    func getPost() -> PostInfoModel? {
        return postData.value
    }
    func isLikeVaild(){
        if let post = getPost() {
            let like = post.likes.contains(UserDefaultsManager.id)
            isLike.accept(like)
        }
    }
    
    func postSearch() {
        guard let postData = postData.value else { return }
        let postInfo = NetworkManager.shared.request(type: PostInfoModel.self, api: .postSearch(postId: postData._id))
        postInfo.subscribe(with: self) { owner, value in
            print("포스트 한개 조회")
            print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
            print(value)
            owner.postData.accept(value)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errortext = testErrorType.message()
                print(errortext)
            }
        } onCompleted: { _ in
            print("네트워크완료")
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
        } onCompleted: { _ in
            print("완료")
        } onDisposed: { _ in
            print("디스포즈")
        }.disposed(by: disposeBag)
    }
    
}
