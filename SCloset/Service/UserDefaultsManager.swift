//
//  UserDefultsManager.swift
//  SCloset
//
//  Created by 이상남 on 11/22/23.
//

import Foundation

struct UserDefaultsManager {
    @UserDefaultsWrapper(key: "isLogin", defaultValue: false)
    static var isLogin
    @UserDefaultsWrapper(key: "token", defaultValue: "")
    static var token
    @UserDefaultsWrapper(key: "refresh", defaultValue: "")
    static var refresh
    @UserDefaultsWrapper(key: "id", defaultValue: "")
    static var id
    @UserDefaultsWrapper(key: "nickname", defaultValue: "")
    static var nickname
}

@propertyWrapper
private struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
