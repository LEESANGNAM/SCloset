//
//  HomeViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/26/23.
//

import Foundation
import RxSwift
import RxCocoa

class StyleListViewModel {
 
    let disposeBag = DisposeBag()
    let postData = BehaviorRelay<[PostLoad]>(value: [])
    let cursor = BehaviorRelay(value: "")
    
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let viewWillAppear: Observable<Void>
        let addButtonTap: ControlEvent<Void>
        let cellTap: ControlEvent<IndexPath>
        let modelSelect: ControlEvent<PostLoad>
    }
    
    struct Output {
        let addButtonTap: ControlEvent<Void>
        let postData: BehaviorRelay<[PostLoad]>
    }
    
    func transform(input: Input) -> Output{
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                WeatherManager.shared.updateWeather()
            }.disposed(by: disposeBag)
        
        input.viewWillAppear
            .delay(.milliseconds(50), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                MyInfoManager.shared.fetch()
                owner.postData.accept([])
                owner.cursor.accept("")
                owner.postLoad()
            }.disposed(by: disposeBag)
        
        
        return Output( addButtonTap: input.addButtonTap, postData: postData)
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
    
    func postLoad(){

        let result = NetworkManager.shared.request(type: PostLoadResponseModel.self, api: .postLoad(next: cursor.value, limit: "10", product_id: APIKey.product))
        result.subscribe(with: self) { owner, value in
            var data = owner.postData.value
            data.append(contentsOf: value.data)
            owner.postData.accept(data)
            owner.setCursor(value.next_cursor)
//            print("포스트 조회기능 : ", value.data)
//            print("포스트 cusor : ", value.next_cursor)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errorText = testErrorType.message()
                print(errorText)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
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
