//
//  StyleDetailViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/7/23.
//

import UIKit
import Kingfisher

class StyleDetailViewController: BaseViewController {
    
    let mainView = StyleDetailView()
    var testData: PostLoad?
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "게시물"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setData()
    }
    
    func setData(){
        if let testData {
            mainView.profileView.nicknameLabel.text = testData.creator.nick
            mainView.profileView.profileImageView.image = UIImage(systemName: "person")
            mainView.profileView.dateLabel.text = testData.time
            setImage(data: testData)
            
            mainView.contentLabel.text = testData.content
            mainView.locationLabel.text = testData.content1
            
            mainView.likeCountLabel.text = "좋아요 \(testData.likes.count)개"
            mainView.commentCountLabel.text = "댓글 \(testData.comments?.count)개"
        }
    }
    
    private func setImage(data: PostLoad) {
        view.layoutIfNeeded()
        mainView.profileView.profileImageView.layer.cornerRadius = mainView.profileView.profileImageView.frame.width / 2
        mainView.commentView1.profileImageView.layer.cornerRadius = mainView.commentView1.profileImageView.frame.width / 2
        if let imageBase = data.image.first,
           let imageBase,
           let url = URL(string: APIKey.baseURL +  imageBase){
            
            let imageSize = mainView.lookImageView.frame.size
            let dowunSizeProcessor = DownsamplingImageProcessor(size: imageSize ) //사이즈만큼 줄이기
            mainView.lookImageView.kf.indicatorType = .activity //인디케이터
            
            let imageLoadRequest = AnyModifier { request in
                var requestBody = request
                requestBody.setValue(APIKey.key, forHTTPHeaderField: "SesacKey")
                requestBody.setValue(UserDefaultsManager.token, forHTTPHeaderField: "Authorization")
                return requestBody
            }
            
            mainView.lookImageView.kf.setImage(
                with: url,
                options: [
                    .processor(dowunSizeProcessor),
                    .requestModifier(imageLoadRequest)
                ]) { result in
                    switch result {
                    case .success(_):
                        print("성공")
                    case .failure(_):
                        print("실패")
                    }
                }
        }
    }
    
}
