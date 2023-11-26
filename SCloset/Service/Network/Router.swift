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
    case postLoad(next: String, limit: String, product_id: String)
    
    private var baseURL: URL {
        return URL(string: APIKey.baseURL)!
    }

    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .join:
            return "/join"
        case .emailVlidation:
            return "/validation/email"
        case .postLoad(let next, let limit, let id):
            return "/post"
//            ?next=\(next)&limit=\(limit)&product_id=\(id)"
        }
    }
    
    
    var header: HTTPHeaders {
        switch self {
        case .join, .login, .emailVlidation:
            return ["SesacKey": Router.key ]
        case .postLoad:
            return ["SesacKey": Router.key, "Authorization": UserDefaultsManager.token ]
        }
//        return ["SesacKey": Router.key ]
    }
    var method: HTTPMethod {
        switch self {
        case .join, .login, .emailVlidation:
            return .post
        case .postLoad:
            return .get
        }
    }
//    var query: [String: String] {
//        switch self {
//        case .join, .login, .emailVlidation:
//            return ["":""]
//        }
//    }
    
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
        case .postLoad:
            break
        }
        
        
        return requst
    }
    
    
}

