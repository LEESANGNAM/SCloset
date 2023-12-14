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
    case postSearch(postId: String)
    case postUpLoad(imageData: Data, title: String, content: String,product_id: String, content1: String)
    case postChange(postId: String, imageData: Data?, title: String?, content: String?)
    case postLike(postId: String)
    
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
        case .postLoad(_,_,_):
            return "post"
        case .postUpLoad:
            return "post"
        case .postChange(let postId,_,_,_):
            return "post/\(postId)"
        case .postLike(let postId):
            return "post/like/\(postId)"
        case .postSearch(let postId):
            return "post/\(postId)"
        }
    }
    
    
    var header: HTTPHeaders {
        switch self {
        case .join, .login, .emailVlidation,.postLoad, .postLike,.postSearch:
            return ["SesacKey": Router.key ]
        case .refresh:
            return [
                "SeSacKey": Router.key,
                "Authorization": UserDefaultsManager.token,
                "Refresh": UserDefaultsManager.refresh
            ]
        case .postUpLoad,.postChange:
            return [
                "SeSacKey": Router.key,
                "Content-Type": "multipart/form-data"
            ]
        }
//        return ["SesacKey": Router.key ]
    }
    var method: HTTPMethod {
        switch self {
        case .join, .login, .emailVlidation,.postUpLoad,.postLike:
            return .post
        case .postLoad, .refresh,.postSearch:
            return .get
        case .postChange:
            return .put
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
            let multipart = MultipartFormData()
            multipart.append(title.data(using: .utf8)!, withName: "title")
            multipart.append(content.data(using: .utf8)!, withName: "content")
            multipart.append(imageData, withName: "file", fileName: "testImage.jpeg", mimeType: "image/jpeg")
            multipart.append(product_id.data(using: .utf8)!, withName: "product_id")
            multipart.append(content1.data(using: .utf8)!, withName: "content1")
            return multipart
        case .postChange(_, let imageData, let title, let content):
            let multipart = MultipartFormData()
            if let imageData {
                multipart.append(imageData, withName: "file",fileName: "image.jpeg",  mimeType: "image/jpeg")
            }
            if let title {
                multipart.append(title.data(using: .utf8)!, withName: "title")
            }
            
            if let content {
                multipart.append(content.data(using: .utf8)!, withName: "content")
            }
            return multipart
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
        case .postLoad:
            requst = try URLEncodedFormParameterEncoder(destination: .queryString).encode(query, into: requst)
        case .refresh, .postUpLoad,.postChange,.postLike,.postSearch:
            break
        }
        return requst
    }
    
    
}

