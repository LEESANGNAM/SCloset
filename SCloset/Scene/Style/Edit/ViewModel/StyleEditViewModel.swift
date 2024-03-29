//
//  StyleAddViewModel.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import Foundation
import RxSwift
import RxCocoa

class StyleEditViewModel {
    let disposeBag = DisposeBag()
    private var titleText = ""
    private var contentText = ""
    private var placeHoler = "내용을 입력해주세요~ "
    private let imageDataRelay = BehaviorRelay<Data?>(value: nil)
    private var locationMessage =  BehaviorRelay<String>(value: "")
    var postData = BehaviorRelay<PostInfoModel?>(value: nil)
    private var errorMessage =  PublishRelay<String>()
    private let netWorkSucces = BehaviorRelay<(PostInfoModel?,Bool)>(value: (nil,false))
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
        let netWorkSucces: BehaviorRelay<(PostInfoModel?,Bool)>
        let contentTextViewDidBeginEditing:  ControlEvent<()>
        let contentTextViewDidEndEditing:  ControlEvent<()>
        let postData: BehaviorRelay<PostInfoModel?>
        let imageDataRelay: BehaviorRelay<Data?>
    }
    
    func transform(input: Input) -> Output {
        var postInfoData = BehaviorRelay<PostInfoModel?>(value: nil)
        input.viewDidLoad
            .bind(with: self) { owner, _ in
                if let result = WeatherManager.shared.getTodayWeather() {
                    let location = result.location
                    let temperature = result.temperatureString
                    let text = "\(location) : \(temperature)"
                    owner.locationMessage.accept(text)
                }
            }.disposed(by: disposeBag)
        
        if let data = postData.value {
            postInfoData.accept(data)
        }
        
        postInfoData
            .bind(with: self) { owner, data in
                guard let data else { return }
                owner.locationMessage.accept(data.content1!)
            }.disposed(by: disposeBag)
        
        input.titleTextfieldChange
            .bind(with: self) { owner, text in
                owner.titleText = text
                print("여기 타이틀텍스트 바뀌는지점",text)
            }.disposed(by: disposeBag)
        
        input.contentTextViewChange
            .bind(with: self) { owner, text in
                owner.contentText = text
                print("여기 컨텐트텍스트 바뀌는지점",text)
            }.disposed(by: disposeBag)
        
        input.doneButtonTapped
            .bind(with: self) { owner, _ in
                if let postInfo = owner.postData.value{
                    owner.changePost(postInfo: postInfo)
                } else {
                    owner.postUpLoad()
                }
            }.disposed(by: disposeBag)
    
        
        return Output(
            locationMessage: locationMessage,
            errorMessage: errorMessage,
            netWorkSucces: netWorkSucces,
            contentTextViewDidBeginEditing: input.contentTextViewDidBeginEditing,
            contentTextViewDidEndEditing: input.contentTextViewDidEndEditing,
            postData: postInfoData, imageDataRelay: imageDataRelay
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
        if contentText == placeHoler {
            contentText = ""
        }
        let test = NetworkManager.shared.upload(type: PostInfoModel.self, api: .postUpLoad(imageData: data, title: titleText, content: contentText, product_id: APIKey.product, content1: locationMessage.value))
        test.subscribe(with: self) { owner, value in
            print("포스트 작성기능 : ", value)
            owner.netWorkSucces.accept((value,true))
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errortext = testErrorType.message()
                print(errortext)
                owner.errorMessage.accept(errortext)
            }
        } onCompleted: { _ in
            print("네트워킹 완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)
    }
    
    func changePost(postInfo: PostInfoModel) {
        guard let data = imageDataRelay.value  else { return }
        let postInfo = NetworkManager.shared.upload(type:PostInfoModel.self ,api: .postChange(postId: postInfo._id, imageData: data, title: titleText, content: contentText))
        
        postInfo.subscribe(with: self) { owner, value in
            print("포스트 수정후 모델",value)
            owner.netWorkSucces.accept((value,true))
        } onError: { owner, error in
            if let testErrorType = error as? NetWorkError {
                let errortext = testErrorType.message()
                print(errortext)
                owner.errorMessage.accept(errortext)
            }
        } onCompleted: { _ in
            print("네트워크완료")
        } onDisposed: { _ in
            print("네트워크 디스포즈")
        }.disposed(by: disposeBag)
    }
}
