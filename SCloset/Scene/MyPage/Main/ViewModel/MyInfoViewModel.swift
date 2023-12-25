//
//  MyInfoViewModel.swift
//  SCloset
//
//  Created by 이상남 on 12/17/23.
//

import Foundation
import RxSwift
import RxCocoa

class MyInfoViewModel: ViewModelProtocol {
   
    let disposeBag = DisposeBag()
    struct Input {
        let viewWillAppear: Observable<Void>
        let profileEditButtonTap: ControlEvent<Void>
        let logOutButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let viewWillAppear: Observable<Void>
        let profileEditButtonTap: ControlEvent<Void>
        let logOutButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        input.viewWillAppear
            .bind(with: self) { _, _ in
                MyInfoManager.shared.fetch()
            }.disposed(by: disposeBag)
        
        return Output(viewWillAppear: input.viewWillAppear,
                      profileEditButtonTap: input.profileEditButtonTap,
                      logOutButtonTap: input.logOutButtonTap)
    }
    
}
