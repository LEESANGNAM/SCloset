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
    
    
    func testRoadPost(){

        let test = NetworkManager.shared.request(type: PostLoadResponseModel.self, api: .postLoad(next: "", limit: "", product_id: "Scloset"))
        test.subscribe(with: self) { owner, value in
            print("포스트 조회기능 : ", value)
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
    
}
