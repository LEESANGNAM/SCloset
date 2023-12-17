//
//  MyInfoViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit
import RxCocoa
import RxSwift

class MyInfoViewController: BaseViewController {
    
    let mainView = MyInfoView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "마이페이지"
        test()
    }
    
    private func test() {
        let myinfo = NetworkManager.shared.request(type: MyProfileModel.self, api: .myInfo)
        myinfo.subscribe(with: self) { owner, value in
            print("내 프로필", value)
        } onError: { owner, error in
            if let networkError = error as? NetWorkError {
                let errorText = networkError.message()
                print(errorText)
            }
        } onCompleted: { _ in
            print("완료")
        } onDisposed: { _ in
            print("디스포즈")
        }

    }
}
