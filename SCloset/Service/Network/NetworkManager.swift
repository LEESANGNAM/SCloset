//
//  NetworkManager.swift
//  SCloset
//
//  Created by 이상남 on 11/16/23.
//

import Foundation
import RxSwift
import Alamofire



class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){ }
    
    
    func request<T: Decodable>(type: T.Type, api: Router) -> Observable<T> {
        return Observable<T>.create { observer in
            AF.request(api,interceptor: TokenIntercetor()).validate(statusCode: 200..<300).responseData { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch response.result {
                case .success(let data):
                    do {
                        print(data)
                        let dataResult = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(dataResult)
                        observer.onCompleted()
                    } catch {
                        print("리스폰스 변환실패")
                        
                    }
                case .failure(let error):
                    do {
                        guard let data = response.data else { return }
                        let errorMessage = try JSONDecoder().decode(ErrorResponseMessages.self, from: data)
                        let errorType = NetWorkError(statusCode: statusCode, message: errorMessage.message)
                        observer.onError(errorType)
                    } catch {
                        print("에러메세지 변환실패")
                    }
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func postUpload(imageData: Data, title: String, content: String, product_id: String, content1: String) -> Observable<PostUpLoad> {
        return Observable<PostUpLoad>.create { observer in
        AF.upload(
            multipartFormData: Router.postUpLoad(imageData: imageData, title: title, content: content, product_id: product_id, content1: content1).multipart,
            with: Router.postUpLoad(imageData: imageData, title: title, content: content, product_id: product_id, content1: content1), interceptor: TokenIntercetor()).validate(statusCode: 200..<300).responseData { response in
                guard let statusCode = response.response?.statusCode else { return }
                switch response.result {
                case .success(let data):
                    print("성공")
                    do {
                        print(data)
                        let dataResult = try JSONDecoder().decode(PostUpLoad.self, from: data)
                        observer.onNext(dataResult)
                        observer.onCompleted()
                    } catch {
                        print("리스폰스 변환실패")
                    }
                case .failure(let error):
                    do {
                        guard let data = response.data else { return }
                        let errorMessage = try JSONDecoder().decode(ErrorResponseMessages.self, from: data)
                        let errorType = NetWorkError(statusCode: statusCode, message: errorMessage.message)
                        print(errorType)
                    } catch {
                        print("에러메세지 변환실패")
                    }
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    
    
}
