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
    
}
