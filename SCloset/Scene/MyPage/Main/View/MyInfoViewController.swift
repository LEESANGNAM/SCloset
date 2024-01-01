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
    let viewModel = MyInfoViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "마이페이지"
        mainView.scrollView.delegate = self
        bind()
    }
    
    
    private func bind() {
        let input = MyInfoViewModel.Input(viewWillAppear: self.rx.viewWillAppear.map { _ in },
                                          profileEditButtonTap: mainView.profileEditButton.rx.tap,
                                          logOutButtonTap: mainView.logOutButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.setData()
            }.disposed(by: disposeBag)
        
        output.profileEditButtonTap
            .bind(with: self) { owner, _ in
                owner.showProfileEditScreen()
            }.disposed(by: disposeBag)
        
        output.logOutButtonTap
            .bind(with: self) { owner, _ in
                owner.showAlert()
            }.disposed(by: disposeBag)
        
    }
    private func showProfileEditScreen(){
        var imagedata: Data?
        if let profile = MyInfoManager.shared.myinfo?.profile {
            imagedata = mainView.profileImageView.image?.jpegData(compressionQuality: 1.0)
        }
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
    private func showAlert() {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let done = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] _ in
            self?.logout()
        }
        alert.addAction(done)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    private func logout(){
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

extension MyInfoViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {               
               // 프로필뷰가 보일 때
               if scrollView.contentOffset.y < 83 {
                   // 첫 번째 뷰 컨트롤러(MyPostViewController)에 대한 접근
                   if let myPostViewController = mainView.tabmanVC.ViewControllers.first as? MyPostViewController {
                       myPostViewController.collectionView.isScrollEnabled = false
                       // 첫 번째 뷰 컨트롤러의 컬렉션뷰 사용 불가능
                   }

                   // 두 번째 뷰 컨트롤러(MyLikePostViewController)에 대한 접근
                   if let myLikePostViewController = mainView.tabmanVC.ViewControllers.last as? MyLikePostViewController {
                       myLikePostViewController.collectionView.isScrollEnabled = false
                       // 두 번째 뷰 컨트롤러의 컬렉션뷰 사용 불가능
                   }
               } else {
                   // 프로필뷰가 가려질 때

                   // 첫 번째 뷰 컨트롤러(MyPostViewController)에 대한 접근
                   if let myPostViewController = mainView.tabmanVC.ViewControllers.first as? MyPostViewController {
                       myPostViewController.collectionView.isScrollEnabled = true
                       // 첫 번째 뷰 컨트롤러의 컬렉션뷰 사용 가능
                   }

                   // 두 번째 뷰 컨트롤러(MyLikePostViewController)에 대한 접근
                   if let myLikePostViewController = mainView.tabmanVC.ViewControllers.last as? MyLikePostViewController {
                       myLikePostViewController.collectionView.isScrollEnabled = true
                       // 두 번째 뷰 컨트롤러의 컬렉션뷰 사용 가능
                   }
               }
           }
}
