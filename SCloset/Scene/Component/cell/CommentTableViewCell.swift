//
//  CommentTableViewCell.swift
//  SCloset
//
//  Created by 이상남 on 12/11/23.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell {
    let identifier = "CommentTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setconstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "person")
        view.backgroundColor = .systemGray5
        view.tintColor = .lightGray
        return view
    }()
    let nickNameLabel = NickNameLabel()
    let dateLabel = CommonGrayStyleLabel()
    let commentLabel = {
        let view = UILabel()
        view.text = "코멘트☄️🌪️코멘트☄️🌪️코멘트☄️🌪️코멘트☄️🌪️코멘트☄️🌪️"
        view.numberOfLines = 0
        return view
    }()
    
    func setHierarchy() {
        addSubview(profileImageView)
        addSubview(nickNameLabel)
        addSubview(dateLabel)
        addSubview(commentLabel)
        nickNameLabel.text = "닉네임"
        dateLabel.text = "0시간"
    }
    
    func setconstraints() {
        profileImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(10)
            make.size.equalTo(40)
        }
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.top)
            make.leading.equalTo(nickNameLabel.snp.trailing).offset(5)
            make.trailing.lessThanOrEqualTo(self.safeAreaLayoutGuide)
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.leading.equalTo(nickNameLabel.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
        }
        
    }
    
    func setData(size: CGSize,data: Comment){
        print("프로필 사이즈",size)
        profileImageView.layer.cornerRadius = size.width / 2
        profileImageView.clipsToBounds = true
        if let imageBase = data.creator.profile {
            let urlString = APIKey.baseURL +  imageBase
            profileImageView.setImage(with: urlString, frameSize: size, placeHolder: "person.fill")
        } else {
            print("프로필 여기서 넣음")
            profileImageView.image = UIImage(systemName: "person.fill")
        }
        nickNameLabel.text = data.creator.nick
        dateLabel.text = data.time.toDate()?.relativeDate()
        commentLabel.text = data.content
        
    }
    
}
