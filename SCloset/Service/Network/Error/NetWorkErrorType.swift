//
//  NetWorkErrorType.swift
//  SCloset
//
//  Created by 이상남 on 11/26/23.
//

import Foundation

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
