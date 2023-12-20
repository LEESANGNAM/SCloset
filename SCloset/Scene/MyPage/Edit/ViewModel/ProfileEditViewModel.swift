//
//  ProfileEditViewModel.swift
//  SCloset
//
//  Created by 이상남 on 12/20/23.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileEditViewModel {
    let disposeBag = DisposeBag()
    private var nicknameText = ""
    private var phoneNumText = ""
    private var birthDayText = ""
    private let profile = BehaviorRelay<MyProfileModel?>(value: nil)
    private let profileImageData = BehaviorRelay<Data?>(value: nil)
    private let imageDataValid = BehaviorRelay<Bool>(value: true) // 이미지 용량 넘어가면 버튼 사라지게 할 옵션
    private var errorMessage =  PublishRelay<String>()
    private let netWorkSucces = BehaviorRelay<Bool>(value: false)
    struct Input {
        let viewDidLoad: Observable<Void>
        let nicknameTextfieldChange: ControlProperty<String>
        let phoneNumTextfieldChange: ControlProperty<String>
        let birthDayTextfieldChange: ControlProperty<String>
        let doneButtonTapped: ControlEvent<Void>
    }
    struct Output {
        let errorMessage: PublishRelay<String>
        let netWorkSucces: BehaviorRelay<Bool>
        let profileImageData: BehaviorRelay<Data?>
        let profile: BehaviorRelay<MyProfileModel?>
        let imageDataValid: BehaviorRelay<Bool>
    }
    
    func transform(input: Input) -> Output {

        input.viewDidLoad
            .bind(with: self) { owner, _ in
                let myInfo = MyInfoManager.shared.myinfo
                owner.profile.accept(myInfo)
            }.disposed(by: disposeBag)
        
        profileImageData
            .bind(with: self) { owner, data in
                owner.isValidImageData(data)
            }.disposed(by: disposeBag)
        
        input.nicknameTextfieldChange
            .bind(with: self) { owner, text in
                owner.nicknameText = text
            }.disposed(by: disposeBag)
        
        input.phoneNumTextfieldChange
            .bind(with: self) { owner, text in
                owner.phoneNumText = text
            }.disposed(by: disposeBag)
        
        input.birthDayTextfieldChange
            .bind(with: self) { owner, text in
                owner.birthDayText = text
            }.disposed(by: disposeBag)

        input.doneButtonTapped
            .bind(with: self) { owner, _ in
                print("던버튼 탭")
            }.disposed(by: disposeBag)
    
       return Output(
        errorMessage: errorMessage,
        netWorkSucces: netWorkSucces,
        profileImageData: profileImageData,
        profile: profile,
        imageDataValid: imageDataValid
       )
    }
    
    func setImageData(_ data: Data?) {
        profileImageData.accept(data)
    }
    private func isValidImageData(_ data: Data?) {
        if let data {
            let dataByteSize = data.count
            if dataByteSize > 1024 * 1024 { // 1MB를 넘는지 확인
                print("데이터 크기가 1MB를 넘습니다.")
                imageDataValid.accept(true)
            } else {
                print("데이터 크기가 1MB를 넘지 않습니다.")
                imageDataValid.accept(false)
            }
        } else {
            print("데이터 없어서 용량 체크 필요없음")
            imageDataValid.accept(false)
        }
    }
}
