//
//  StyleDetailViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/7/23.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class StyleDetailViewController: BaseViewController {
    
    let mainView = StyleDetailView()
    let disposeBag = DisposeBag()
    let viewModel: StyleDetailViewModel
    
    init(viewModel: StyleDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = .white
        title = "게시물"
    }
    
    func bind() {
        let profileView = mainView.profileView
        let commentWriteView = mainView.commentWriteView
        let input = StyleDetailViewModel.Input(
            viewWillAppear: self.rx.viewWillAppear.map{_ in},
            followButtonTapped: profileView.followButton.rx.tap,
            ellipsisButtonTapped: profileView.ellipsisButton.rx.tap,
            likeButtonTapped: mainView.likeButton.rx.tap,
            commentButtonTapped: mainView.commentButton.rx.tap,
            commentWriteTextFieldChange: commentWriteView.commentTextField.rx.text.orEmpty,
            commentDoneButtonTapped: commentWriteView.doneButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.viewWillAppear
            .bind(with: self) { owner, _ in
                owner.setData()
            }.disposed(by: disposeBag)
        
        output.commentButtonTapped
            .bind(with: self) { owner, _ in
                owner.mainView.commentWriteView.commentTextField.becomeFirstResponder()
            }.disposed(by: disposeBag)
        
        output.ellipsisButtonTapped
            .bind(with: self) { owner, _ in
                owner.showPostActionSheet {
                    print("수정")
                } deleteAction: {
                    print("삭제")
                }

            }.disposed(by: disposeBag)
        
        
    }
    
   private func setData(){
        let postdata = viewModel.postData
            mainView.profileView.nicknameLabel.text = postdata.creator.nick
            mainView.profileView.profileImageView.image = UIImage(systemName: "person")
            mainView.profileView.dateLabel.text = postdata.time
            setImage(data: postdata)
            
            mainView.contentLabel.text = postdata.content
            mainView.locationLabel.text = postdata.content1
            
            mainView.likeCountLabel.text = "좋아요 \(postdata.likes.count)개"
        mainView.commentCountLabel.text = "댓글 \(postdata.comments.count)개"
    }
    
    private func setImage(data: PostLoad) {
        view.layoutIfNeeded()
        mainView.profileView.setData(corner: mainView.profileView.profileImageView.frame.width / 2)

        mainView.commentView1.setData(corner: mainView.commentView1.profileImageView.frame.width / 2)
        if let imageBase = data.image.first,
           let imageBase{
            let urlString = APIKey.baseURL +  imageBase
            let imageSize = mainView.lookImageView.frame.size
            
            mainView.lookImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "star")
        }
    }
    
    private func showPostActionSheet(editAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let editAction = UIAlertAction(title: "게시글 수정", style: .default) { _ in
            editAction()
        }
        
        let deleteAction = UIAlertAction(title: "게시글 삭제", style: .destructive) { _ in
            deleteAction()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionSheet.addAction(editAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
}
