//
//  StyleDetailView.swift
//  SCloset
//
//  Created by 이상남 on 12/6/23.
//

import UIKit

class StyleDetailView: BaseView {
    let scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    let contentView = UIView()
    lazy var contentList: [UIView] = [
        profileView,
        lookImageView,
        likeButton,commentButton,locationLabel,
        likeCountLabel,commentCountLabel,
        contentLabel,
        commentLabel
    ]
    
    let profileView = ProfileView()
    let lookImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemGray5
        view.contentMode = .scaleAspectFill
        return view
    }()
    let likeButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.contentHorizontalAlignment = .fill
        view.contentVerticalAlignment = .fill
        view.tintColor = .black
        return view
    }()
    let commentButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "message"), for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.contentHorizontalAlignment = .fill
        view.contentVerticalAlignment = .fill
        view.tintColor = .black
        return view
    }()
    let locationLabel = CommonGrayStyleLabel()
    let likeCountLabel = {
        let view = UILabel()
        view.text = "좋아요 340개"
        return view
    }()
    let commentCountLabel = {
        let view = UILabel()
        view.text = "댓글 340개"
        return view
    }()
    let contentLabel = {
        let view = UILabel()
        view.text = "내용내용내용내용 제목, 내용 다 여기다가 넣을 예정 없으면 아예 빈칸"
        view.numberOfLines = 0
        return view
    }()
    let commentLabel = {
        let view = UILabel()
        view.text = """
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                        댓글 뷰 새로 넣을 꺼임
                    """
        view.numberOfLines = 0
        return view
    }()
    
    override func setHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentList.forEach { contentView.addSubview($0) }
        profileView.nicknameLabel.text = "닉네임"
        profileView.dateLabel.text = "0일전"
        locationLabel.text = "서울특별시 00동 00도/00도"
    }
    
    override func setconstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.width.equalTo(scrollView)
        }
        profileView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView)
            make.height.equalTo(60)
        }
        lookImageView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.width.equalTo(contentView)
            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.8)
        }
        likeButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(lookImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        commentButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(lookImageView.snp.bottom).offset(10)
            make.leading.equalTo(likeButton.snp.trailing).offset(20)
        }
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.trailing.equalToSuperview().offset(-10)
        }
        likeCountLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.equalTo(likeButton.snp.leading)
            make.trailing.equalTo(commentButton.snp.trailing)
        }
        commentCountLabel.snp.makeConstraints { make in
            make.trailing.equalTo(locationLabel.snp.trailing)
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(likeCountLabel.snp.bottom).offset(10)
            make.leading.equalTo(likeCountLabel.snp.leading)
            make.trailing.equalTo(commentCountLabel.snp.trailing)
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
            make.width.equalTo(contentView)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        
        
    }
    
    
}
