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
//        let followResult: PublishRelay<Bool>
        let commentButtonTapped: ControlEvent<Void>
        let commentDoneButtonTapped: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output{
        input.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.changePost()
            }.disposed(by: disposeBag)
        
        return Output(viewWillAppear: input.viewWillAppear, ellipsisButtonTapped: input.ellipsisButtonTapped, commentButtonTapped: input.commentButtonTapped, commentDoneButtonTapped: input.commentDoneButtonTapped)
    }
    
    func additem() {
        item.append("테스트\(Int.random(in: 1...500))")
    }
    
    func getPost() -> PostInfoModel? {
        return postData.value
    }
    
    func changePost() {
        guard let postData = postData.value else { return }
        print("ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
        print("title: ",postData.title)
        print("contenText: ",postData.content)
        let postInfo = NetworkManager.shared.postUpload(api: .postChange(postId: postData._id, imageData: nil, title: postData.title, content: postData.content))
        
        postInfo.subscribe(with: self) { owner, value in
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
    
}
