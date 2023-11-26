//
//  HomeViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/26/23.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
 
    let disposeBag = DisposeBag()
    
    
    func testRoadPost(){

        let test = NetworkManager.shared.request(type: PostLoadResponseModel.self, api: .postLoad(next: "", limit: "", product_id: ""))
        test.subscribe(with: self) { owner, value in
            print("포스트 조회기능 : ", value)
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                switch testErrorType {
                    case let .notKey(statusCode, message),
                         let .overcall(statusCode, message),
                         let .requestPathError(statusCode, message),
                         let .missingParameter(statusCode, message),
                         let .notUser(statusCode, message),
                         let .invalidServerError(statusCode, message):
                    print("오류코드 \(statusCode): \(message) ")
                    }
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)
    }
    
}
