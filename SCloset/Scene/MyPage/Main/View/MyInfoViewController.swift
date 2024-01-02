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
    var innerScrollingDownDueToOuterScroll = false
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "마이페이지"
        mainView.outerScrollView.delegate = self
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
    
    private enum Policy {
           static let floatingPointTolerance = 0.1
       }
       
       func scrollViewDidScroll(_ scrollView: UIScrollView) {
           // more, less 스크롤 방향의 기준: 새로운 콘텐츠로 스크롤링하면 more, 이전 콘텐츠로 스크롤링하면 less
           // ex) more scroll 한다는 의미: 손가락을 아래에서 위로 올려서 새로운 콘텐츠를 확인한다
           
           guard let innerScrollView = mainView.innerScrollView else {
               // innerScrollView가 nil일 경우 처리
               print("이너스크롤 있어야함 무조건 있을꺼임 없으면 큰일남")
               return
           }
           
           let outerScroll = mainView.outerScrollView == scrollView
           let innerScroll = !outerScroll
           let moreScroll = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
           let lessScroll = !moreScroll
           
           let outerScrollView = mainView.outerScrollView
           // outer scroll이 스크롤 할 수 있는 최대값 (이 값을 sticky header 뷰가 있다면 그 뷰의 frame.maxY와 같은 값으로 사용해도 가능)
           let outerScrollMaxOffsetY = outerScrollView.contentSize.height - outerScrollView.frame.height + 80
           let innerScrollMaxOffsetY = innerScrollView.contentSize.height - innerScrollView.frame.height
           print("outerScrollMaxOffsetY : \(outerScrollMaxOffsetY)")
           print("outerScrollView.contentSize.height  : \(outerScrollView.contentSize.height )")
           print("outerScrollView.frame.height  : \(outerScrollView.frame.height )")
           print("mainView.myProfileInfoView.frame.height  : \(mainView.myProfileInfoView.frame.height )")

           // 1. outer scroll을 more 스크롤
           // 만약 outer scroll을 more scroll 다 했으면, inner scroll을 more scroll
           if outerScroll && moreScroll {
               guard outerScrollMaxOffsetY < outerScrollView.contentOffset.y + Policy.floatingPointTolerance else { return }
               innerScrollingDownDueToOuterScroll = true
               defer { innerScrollingDownDueToOuterScroll = false }
               
               // innerScrollView를 모두 스크롤 한 경우 stop
               guard innerScrollView.contentOffset.y < innerScrollMaxOffsetY else { return }
               innerScrollView.contentOffset.y = innerScrollView.contentOffset.y + outerScrollView.contentOffset.y - outerScrollMaxOffsetY
               outerScrollView.contentOffset.y = outerScrollMaxOffsetY
               
           }
           
           // 2. outer scroll을 less 스크롤
           // 만약 inner scroll이 less 스크롤 할게 남아 있다면 inner scroll을 less 스크롤
           if outerScroll && lessScroll {
               guard innerScrollView.contentOffset.y > 0 && outerScrollView.contentOffset.y < outerScrollMaxOffsetY else { return }
               innerScrollingDownDueToOuterScroll = true
               defer { innerScrollingDownDueToOuterScroll = false }
               
               // outer scroll에서 스크롤한 만큼 inner scroll에 적용
               innerScrollView.contentOffset.y = max(innerScrollView.contentOffset.y - (outerScrollMaxOffsetY - outerScrollView.contentOffset.y), 0)
               
               // outer scroll은 스크롤 되지 않고 고정
               
               outerScrollView.contentOffset.y = outerScrollMaxOffsetY
           }
           
           // 3. inner scroll을 less 스크롤
           // inner scroll을 모두 less scroll한 경우, outer scroll을 less scroll
           if innerScroll && lessScroll {
               defer { innerScrollView.lastOffsetY = innerScrollView.contentOffset.y }
               guard innerScrollView.contentOffset.y < 0 && outerScrollView.contentOffset.y > 0 else { return }
               
               // innerScrollView의 bounces에 의하여 다시 outerScrollView가 당겨질수 있으므로 bounces로 다시 되돌아가는 offset 방지
               guard innerScrollView.lastOffsetY > innerScrollView.contentOffset.y else { return }
               
               let moveOffset = outerScrollMaxOffsetY - abs(innerScrollView.contentOffset.y) * 3
               guard moveOffset < outerScrollView.contentOffset.y else { return }
               
               outerScrollView.contentOffset.y = max(moveOffset, 0)
           }
           
           // 4. inner scroll을 more 스크롤
           // outer scroll이 아직 more 스크롤할게 남아 있다면, innerScroll을 그대로 두고 outer scroll을 more 스크롤
           if innerScroll && moreScroll {
               guard
                   outerScrollView.contentOffset.y + Policy.floatingPointTolerance < outerScrollMaxOffsetY,
                   !innerScrollingDownDueToOuterScroll
               else { return }
               // outer scroll를 more 스크롤
               let minOffetY = min(outerScrollView.contentOffset.y + innerScrollView.contentOffset.y, outerScrollMaxOffsetY)
               let offsetY = max(minOffetY, 0)
               outerScrollView.contentOffset.y = offsetY
               
               // inner scroll은 스크롤 되지 않아야 하므로 0으로 고정
               innerScrollView.contentOffset.y = 0
           }
           
           // todo: scroll to top 시, inner scroll도 top으로 스크롤
       }
   }

   private struct AssociatedKeys {
       static var lastOffsetY = "lastOffsetY"
   }

   extension UIScrollView {
       var lastOffsetY: CGFloat {
           get {
               (objc_getAssociatedObject(self, &AssociatedKeys.lastOffsetY) as? CGFloat) ?? contentOffset.y
           }
           set {
               objc_setAssociatedObject(self, &AssociatedKeys.lastOffsetY, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
           }
       }
   }
        

