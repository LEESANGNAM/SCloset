//
//  StyleAddViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import Foundation
import RxSwift
import RxCocoa

class StyleAddViewModel {
    let disposeBag = DisposeBag()
    private var titleText = ""
    private var contentText = ""
    private var placeHoler = "내용을 입력해주세요~ "
    private let imageDataRelay = BehaviorRelay<Data?>(value: nil)
    private var locationMessage =  BehaviorRelay<String>(value: "")
    private var errorMessage =  PublishRelay<String>()
    struct Input {
        let viewDidLoad: Observable<Void>
        let titleTextfieldChange: ControlProperty<String>
        let contentTextViewChange: ControlProperty<String>
        let contentTextViewDidBeginEditing:  ControlEvent<()>
        let contentTextViewDidEndEditing:  ControlEvent<()>
        let doneButtonTapped: ControlEvent<Void>
    }
    struct Output {
        let locationMessage: BehaviorRelay<String>
        let errorMessage: PublishRelay<String>
        let doneButtonTapped: ControlEvent<Void>
        let contentTextViewDidBeginEditing:  ControlEvent<()>
        let contentTextViewDidEndEditing:  ControlEvent<()>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                if let result = WeatherManager.shared.getTodayWeather() {
                    let location = result.location
                    let temperature = result.temperatureString
                    let text = "\(location) : \(temperature)"
                    print("텍스트으으으",text)
                    owner.locationMessage.accept(text)
                }
            }.disposed(by: disposeBag)
        
        input.titleTextfieldChange
            .bind(with: self) { owner, text in
                owner.titleText = text
            }.disposed(by: disposeBag)
        
        input.contentTextViewChange
            .bind(with: self) { owner, text in
                owner.contentText = text
            }.disposed(by: disposeBag)
        
        input.doneButtonTapped
            .bind(with: self) { owner, _ in
                owner.postUpLoad()
            }.disposed(by: disposeBag)
    
        
        return Output(
            locationMessage: locationMessage,
            errorMessage: errorMessage,
            doneButtonTapped: input.doneButtonTapped,
            contentTextViewDidBeginEditing: input.contentTextViewDidBeginEditing,
            contentTextViewDidEndEditing: input.contentTextViewDidEndEditing
        )
    }
    func getPlaceHolder() -> String {
        return placeHoler
    }
    func setImageData(_ imageData: Data?) {
            imageDataRelay.accept(imageData)
    }
    
    func postUpLoad(){
        guard let data = imageDataRelay.value  else { return }
        let test =  NetworkManager.shared.postUpload(imageData: data, title: titleText, content: contentText, product_id: "Scloset", content1: locationMessage.value)
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
