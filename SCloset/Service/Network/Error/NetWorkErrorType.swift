//
//  NetWorkErrorType.swift
//  SCloset
//
//  Created by 이상남 on 11/26/23.
//

import Foundation

enum NetWorkError: Error {
    case notKey(statusCode: Int, message: String) // 420
    case overcall(statusCode: Int, message: String) // 429
    case requestPathError(statusCode: Int, message: String) // 444
    case missingParameter(statusCode: Int, message: String) // 400
    case notAvailable(statusCode: Int, message: String) // 409
    case unauthorized(statusCode: Int, message: String) // 401
    case forbidden(statusCode: Int, message: String) // 403
    case tokenExpired(statusCode: Int, message: String) // 419
    case notFound(statusCode: Int, message: String) // 410
    case insufficientPermissions(statusCode: Int, message: String) // 445
    case invalidServerError(statusCode: Int, message: String) // 500
    case unknownError(statusCode: Int, message: String) // Default case
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
        case 409:
            self = .notAvailable(statusCode: statusCode, message: message)
        case 401:
            self = .unauthorized(statusCode: statusCode, message: message)
        case 403:
            self = .forbidden(statusCode: statusCode, message: message)
        case 419:
            self = .tokenExpired(statusCode: statusCode, message: message)
        case 410:
            self = .notFound(statusCode: statusCode, message: message)
        case 445:
            self = .insufficientPermissions(statusCode: statusCode, message: message)
        case 500:
            self = .invalidServerError(statusCode: statusCode, message: message)
        default:
            self = .unknownError(statusCode: statusCode, message: message)
        }
    }
}

extension NetWorkError {
     func message() -> String {
        switch self {
            case let .notKey(statusCode, message),
                 let .overcall(statusCode, message),
                 let .requestPathError(statusCode, message),
                 let .missingParameter(statusCode, message),
                 let .notAvailable(statusCode, message),
                 let .unauthorized(statusCode, message),
                 let .forbidden(statusCode, message),
                 let .tokenExpired(statusCode, message),
                 let .notFound(statusCode, message),
                 let .insufficientPermissions(statusCode, message),
                 let .invalidServerError(statusCode, message),
                 let .unknownError(statusCode, message):
                return "오류코드 \(statusCode): \(message)"
            }
    }
}
