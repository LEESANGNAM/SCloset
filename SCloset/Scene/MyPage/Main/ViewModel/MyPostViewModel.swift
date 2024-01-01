//
//  MyPostViewModel.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import Foundation
import RxSwift
import RxCocoa

class MyPostViewModel:ViewModelProtocol {
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
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.postData.accept([])
                owner.cursor.accept("")
                print("마이포스트 로드 시작")
                owner.myPostLoad()
            }.disposed(by: disposeBag)
        
        
        return Output( postData: postData)
    }
    
    
    func getPostCount() -> Int {
        print("포스트갯수 함수 : ",postData.value.count)
        print("-----------------")
        return postData.value.count
    }
    func getPostData(index: Int) -> PostLoad {
        return postData.value[index]
    }
    func getCursor() -> String {
        return cursor.value
    }
    
    func myPostLoad() {
        guard let userId =  MyInfoManager.shared.myinfo?._id else { return }
        let likepostTest = NetworkManager.shared.request(type: PostLoadResponseModel.self, api: .myPost(userId: userId, next: cursor.value, limit: "10", product_id: APIKey.product))
        likepostTest.subscribe(with: self) { owner, value in
            var data = owner.postData.value
            data.append(contentsOf: value.data)
            owner.postData.accept(data)
            print("데이터 갯수,",data.count)
            owner.setCursor(value.next_cursor)
        } onError: { owner, error in
            if let networkError = error as? NetWorkError {
                let errorText = networkError.message()
                print(errorText)
            }
        } onCompleted: { _ in
            print("내 게시글 완료")
        } onDisposed: { _ in
            print("내 게시글 디스포즈")
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
