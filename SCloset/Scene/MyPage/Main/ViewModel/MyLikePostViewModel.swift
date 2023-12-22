//
//  MyLikePostViewModel.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import Foundation
import RxSwift
import RxCocoa

class MyLikePostViewModel:ViewModelProtocol {
    let disposeBag = DisposeBag()
    let postData = BehaviorRelay<[PostLoad]>(value: [])
    let cursor = BehaviorRelay(value: "")
    
    
    struct Input {
        let viewWillAppear: Observable<Void>
    }
    
    struct Output {
        let postData: BehaviorRelay<[PostLoad]>
    }
    
    func transform(input: Input) -> Output{
        input.viewWillAppear
            .delay(.milliseconds(50), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.postData.accept([])
                owner.cursor.accept("")
                owner.likePostLoad()
            }.disposed(by: disposeBag)
        
        
        return Output( postData: postData)
    }
    
    
    func getPostCount() -> Int {
        return postData.value.count
    }
    func getPostData(index: Int) -> PostLoad {
        return postData.value[index]
    }
    func getCursor() -> String {
        return cursor.value
    }
    
    func likePostLoad() {
        let likepostTest = NetworkManager.shared.request(type: PostLoadResponseModel.self, api: .myLikePost(next: cursor.value, limit: "10"))
        likepostTest.subscribe(with: self) { owner, value in
            var data = owner.postData.value
            data.append(contentsOf: value.data)
            owner.postData.accept(data)
            owner.setCursor(value.next_cursor)
        } onError: { owner, error in
            if let networkError = error as? NetWorkError {
                let errorText = networkError.message()
                print(errorText)
            }
        } onCompleted: { _ in
            print("좋아요 게시글 완료")
        } onDisposed: { _ in
            print("좋아요 게시글 디스포즈")
        }.disposed(by: disposeBag)
        
    }
    private func setCursor(_ cursor: String) {
        if cursor == "0" {
            self.cursor.accept("")
        } else {
            self.cursor.accept(cursor)
        }
    }
}
