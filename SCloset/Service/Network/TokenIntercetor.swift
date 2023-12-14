//
//  TokenIntercepor.swift
//  SCloset
//
//  Created by 이상남 on 11/26/23.
//

import Alamofire
import RxSwift
import UIKit

class TokenIntercetor: RequestInterceptor {
    let disposeBag = DisposeBag()
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        let token = UserDefaultsManager.token
        urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        print("adapt: \(urlRequest.headers)")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("retry 진입 나와라")
        if let response = request.task?.response {
          print("무슨 리스폰스 타입이지",response)
      } else {
          // 응답이 없는 경우 처리 로직
          print("이건 응답이없는건가?")
      }
        guard let response = request.task?.response as? HTTPURLResponse else {
            print("HttpurlRespose 아님")
            completion(.doNotRetryWithError(error))
            return
        }
        // 리프레시토큰 만료 재로그인
        guard response.statusCode != 418 else {
            DispatchQueue.main.async { [weak self] in
                self?.changeRootView()
            }
            completion(.doNotRetryWithError(error))
            return
        }
        guard response.statusCode == 419 else { // 419 토큰만료
            print("여기서 빠져나가나?")
            completion(.doNotRetryWithError(error))
            return
        }
        
        let result = NetworkManager.shared.request(type: RefreshModel.self, api: .refresh)
        result.subscribe(with: self) { owner, value in
            UserDefaultsManager.token = value.token
            completion(.retry)
        } onError: { owner, error in
            print("리프레시 토큰 에러:",error)
            completion(.doNotRetryWithError(error))
        } onCompleted: { _ in
            print("리프레시토큰 재발급 완료")
        } onDisposed: { _ in
            print("토큰 재발급 완료 사라짐")
        }.disposed(by: disposeBag)

        
        
    }
    
    private func changeRootView(){
        resetLogin()
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = LoginViewController()
                sceneDelegate?.window?.rootViewController = vc
                sceneDelegate?.window?.makeKeyAndVisible()
    }
    private func resetLogin(){
        UserDefaultsManager.isLogin = false
        UserDefaultsManager.token = ""
        UserDefaultsManager.refresh = ""
        UserDefaultsManager.id = ""
    }
}
