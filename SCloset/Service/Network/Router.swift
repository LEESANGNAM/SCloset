//
//  Router.swift
//  SCloset
//
//  Created by 이상남 on 11/15/23.
//


import Foundation
import Alamofire





enum Router: URLRequestConvertible {
    
    private static let key = APIKey.key
    
    case join(SignUpRequestModel)
    case login(LoginRequestModel)
    case emailVlidation(EmailValidRequestModel)
    case refresh
    case postLoad(next: String, limit: String, product_id: String)
    case postUpLoad(imageData: Data, title: String, content: String,product_id: String, content1: String)
    
    private var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }

    private var path: String {
        switch self {
        case .login:
            return "login"
        case .join:
            return "join"
        case .emailVlidation:
            return "validation/email"
        case .refresh:
            return "refresh"
        case .postLoad(let next, let limit, let id):
            return "post"
        case .postUpLoad:
            return "post"
        }
    }
    
    
    var header: HTTPHeaders {
        switch self {
        case .join, .login, .emailVlidation:
            return ["SesacKey": Router.key ]
        case .postLoad:
            return ["SesacKey": Router.key]
        case .refresh:
            return [
                "SeSacKey": Router.key,
                "Authorization": UserDefaultsManager.token,
                "Refresh": UserDefaultsManager.refresh
            ]
        case .postUpLoad:
            return [
                "SeSacKey": Router.key,
                "Content-Type": "multipart/form-data"
            ]
        }
//        return ["SesacKey": Router.key ]
    }
    var method: HTTPMethod {
        switch self {
        case .join, .login, .emailVlidation,.postUpLoad:
            return .post
        case .postLoad, .refresh:
            return .get
        }
    }
    var query: [String: String] {
        switch self {
        case .postLoad(next: let next, limit: let limit, product_id: let product_id):
            return [
                "next": next,
                "limit": limit,
                "product_id": product_id
                    ]
        default:
            return ["":""]
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .postUpLoad(let imageData, let title, let content, let product_id, let content1):
            let mutlpart = MultipartFormData()
            mutlpart.append(title.data(using: .utf8)!, withName: "title")
            mutlpart.append(content.data(using: .utf8)!, withName: "content")
            mutlpart.append(imageData, withName: "file", fileName: "testImage.jpeg", mimeType: "image/jpeg")
            mutlpart.append(product_id.data(using: .utf8)!, withName: "product_id")
            mutlpart.append(content1.data(using: .utf8)!, withName: "content1")
            
            return mutlpart
        
        default: return MultipartFormData()
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var requst = URLRequest(url: url)
        requst.headers = header
        requst.method = method
        
        switch self {
        case .join(let signUpRequestModel):
            requst = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(signUpRequestModel, into: requst)
        case .login(let loginRequestModel):
            requst = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(loginRequestModel, into: requst)
        case .emailVlidation(let emailValidationRequestModel):
            requst = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(emailValidationRequestModel, into: requst)
        case .postLoad(let next,let limit,let product_id):
            requst = try URLEncodedFormParameterEncoder(destination: .queryString).encode(query, into: requst)
        case .refresh:
            break
        case .postUpLoad(let imageData, let title, let content,let product_id, let content1):
            break
//            requst = try AF.upload(
//                multipartFormData: { multipartFormData in
//                    print("ㅡㅡㅡㅡㅡㅡㅡ여기멀티폼데이터안ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
//                    print(multipartFormData)
//                    multipartFormData.append(title.data(using: .utf8)!, withName: "title")
//                    multipartFormData.append(content.data(using: .utf8)!, withName: "content")
//                    multipartFormData.append(imageData, withName: "file", fileName: "testImage.jpeg", mimeType: "image/jpeg")
//                    multipartFormData.append(product_id.data(using: .utf8)!, withName: "product_id")
//                    multipartFormData.append(content1.data(using: .utf8)!, withName: "content1")
//                    
//                    print("ㅡㅡㅡㅡㅡㅡㅡ여기멀티폼데이터안 여긴 끝날 때ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ")
//                    print(multipartFormData)
//                },
//                to: url,
//                method: .post,
//                headers: header
//            ).convertible.asURLRequest()
//            
//            print("파일 업로드 요청 requst: \(requst)")
        }
        return requst
    }
    
    
}

