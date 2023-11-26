//
//  NetworkManager.swift
//  SCloset
//
//  Created by 이상남 on 11/16/23.
//

import Foundation
import RxSwift
import Alamofire

enum NetWorkError: Error {
    case notKey(statusCode: Int, message: String) //= 420
    case overcall(statusCode: Int, message: String) //= 429
    case requestPathError(statusCode: Int, message: String) //= 444
    case missingParameter(statusCode: Int, message: String) //= 400
    case notUser(statusCode: Int, message: String) //= 401
    case invalidServerError(statusCode: Int, message: String) //= 500
    
    init(statusCode: Int, message: String) {
        switch statusCode {
        case 420:
            self = .notKey(statusCode: statusCode, message: message)
        case 429:
            self = .overcall(statusCode: statusCode, message: message)
        case 444:
            self = .requestPathError(statusCode: statusCode, message: message)
        case 400:
            self = .missingParameter(statusCode: statusCode, message: message)
        case 401:
            self = .notUser(statusCode: statusCode, message: message)
        case 500:
            self = .invalidServerError(statusCode: statusCode, message: message)
        default:
            self = .invalidServerError(statusCode: statusCode, message: message)
        }
    }
}
struct ErrorResponseMessages: Decodable {
    let message: String
    
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){ }
    
    
    func request<T: Decodable>(type: T.Type, api: Router) -> Observable<T> {
        return Observable<T>.create { observer in
            AF.request(api,interceptor: TokenIntercetor()).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    guard let statusCode = response.response?.statusCode else { return }
                    let sucess = (200..<300).contains(statusCode)
                    if sucess {
                        do {
                            print(data)
                            let dataResult = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(dataResult)
                            observer.onCompleted()
                        } catch {
                            print("리스폰스 변환실패")
                        }
                    } else {
                        do {
                            let errorMessage = try JSONDecoder().decode(ErrorResponseMessages.self, from: data)
                            let errorType = NetWorkError(statusCode: statusCode, message: errorMessage.message)
                            observer.onError(errorType)
                        } catch {
                            print("에러메세지 변환실패")
                        }
                    }
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
