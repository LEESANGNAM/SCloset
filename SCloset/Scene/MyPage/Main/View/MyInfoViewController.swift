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
        setEditButton()
        title = "마이페이지"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setData()
    }
    
    private func setEditButton() {
        mainView.profileEditButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    @objc func editButtonTapped(){
        var imagedata: Data?
        if let profile = MyInfoManager.shared.myinfo?.profile {
            imagedata = mainView.profileImageView.image?.jpegData(compressionQuality: 1.0)
        }
        print("이미지 데이터 확인 : ", imagedata)
        let vm = ProfileEditViewModel()
        vm.setImageData(imagedata)
        let vc = ProfileEditViewController(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    private func setData(){
        setImage()
        mainView.emailLabel.text = MyInfoManager.shared.myinfo?.email
        mainView.nicknameLabel.text = MyInfoManager.shared.myinfo?.nick
        mainView.followerLabel.text = "팔로워 \(MyInfoManager.shared.followerCount)"
        mainView.followingLabel.text = "팔로잉 \(MyInfoManager.shared.followingCount)"
    }
    private func setImage() {
        view.layoutIfNeeded()
        let imageSize = mainView.profileImageView.frame.size
        mainView.profileImageView.layer.cornerRadius = imageSize.width / 2
        mainView.profileImageView.clipsToBounds = true
        if let imageBase = MyInfoManager.shared.myinfo?.profile {
            let urlString = APIKey.baseURL +  imageBase
            mainView.profileImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "person.fill")
        }else {
            mainView.profileImageView.image = UIImage(systemName: "person.fill")
        }
    }
    
    
}
