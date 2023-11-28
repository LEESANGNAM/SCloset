//
//  StyleAddViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import Foundation
import RxSwift

class StyleAddViewModel {
    
    let disposeBag = DisposeBag()
    
    func postUpLoad(data: Data){
        print(data)
//        let api = Router.postUpLoad(imageData: data, title: "테스트1234", content: "테스트내용1234", product_id: "Scloset", content1: "위치 : 날씨")
        //        let test = NetworkManager.shared.request(type: PostUpLoad.self, api: api)
        let test =  NetworkManager.shared.postUpload(imageData: data, title: "테스트12345", content: "테스트내용12345", product_id: "Scloset", content1: "위치 : 날씨ㅁㄴㅇㄴㅁㅇ")
        test.subscribe(with: self) { owner, value in
            print("포스트 작성기능 : ", value)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errortext = testErrorType.message()
                print(errortext)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)
    }
}
