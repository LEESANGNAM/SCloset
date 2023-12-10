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
    
    var postData: PostLoad
    
    var item: [String] = ["테스트1","테스트2"]
    
    init(postData: PostLoad) {
        self.postData = postData
    }
    
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
     
        
        return Output(viewWillAppear: input.viewWillAppear, ellipsisButtonTapped: input.ellipsisButtonTapped, commentButtonTapped: input.commentButtonTapped, commentDoneButtonTapped: input.commentDoneButtonTapped)
    }
    
    func additem() {
        item.append("테스트\(Int.random(in: 1...500))")
    }
}
