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
        setbackButton()
        bind()
        view.backgroundColor = .white
        title = "게시물"
    }
    
    func bind() {
        mainView.commentTableView.dataSource = self
        mainView.commentTableView.delegate = self
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
        
        output.searchSuccess
            .bind(with: self) { owner, value in
                if value {
                    owner.setData()
                }
            }.disposed(by: disposeBag)
        
        output.commentButtonTapped
            .bind(with: self) { owner, _ in
                owner.mainView.commentWriteView.commentTextField.becomeFirstResponder()
            }.disposed(by: disposeBag)
        
        output.ellipsisButtonTapped
            .bind(with: self) { owner, _ in
                owner.showPostActionSheet {
                    print("수정")
                    if let data = owner.viewModel.getPost(){
                        let vm = StyleEditViewModel()
                        vm.postData.accept(data)
                        vm.setImageData(owner.mainView.lookImageView.image?.jpegData(compressionQuality: 1.0))
                        let vc = StyleEditViewController(viewModel: vm)
                        vc.delegate = self
                        owner.navigationController?.pushViewController(vc, animated: true)
                    }
                } deleteAction: {
                    print("삭제")
                }
            }.disposed(by: disposeBag)
        
        output.item
            .bind(with: self) { owner, _ in
                owner.mainView.commentTableView.reloadData()
            }.disposed(by: disposeBag)
        
        output.isLike
            .bind(with: self) { owner, value in
                owner.setLikeButton(isLike: value)
            }.disposed(by: disposeBag)
        
        output.isCommentValid
            .bind(to: mainView.commentWriteView.doneButton.rx.isHidden)
            .disposed(by: disposeBag)
        
    }
    private func setbackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    @objc func backButtonTapped() {
        if let _ = self.presentingViewController {
            dismiss(animated: true)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
   private func setData(){
       guard let postdata = viewModel.getPost() else { return }
        mainView.profileView.nicknameLabel.text = postdata.creator.nick
        mainView.profileView.profileImageView.image = UIImage(systemName: "person")
        mainView.profileView.dateLabel.text = postdata.time
        setImage(data: postdata)
        mainView.contentLabel.text = postdata.content
        mainView.locationLabel.text = postdata.content1
       mainView.commentWriteView.commentTextField.text = ""
        mainView.likeCountLabel.text = "좋아요 \(postdata.likes.count)개"
        mainView.commentCountLabel.text = "댓글 \(postdata.comments.count)개"
    }
    
    private func setImage(data: PostInfoModel) {
        view.layoutIfNeeded()
        mainView.profileView.setData(corner: mainView.profileView.profileImageView.frame.width / 2, data: data)

        if let imageBase = data.image.first,
           let imageBase{
            let urlString = APIKey.baseURL +  imageBase
            let imageSize = mainView.lookImageView.frame.size
            
            mainView.lookImageView.setImage(with: urlString, frameSize: imageSize, placeHolder: "star")
        }
    }
    private func setLikeButton(isLike: Bool) {
        if isLike {
            mainView.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            mainView.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
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

extension StyleDetailViewController: StyleEditDelegate {
    func didUpdatePostData(_ postData: PostInfoModel) {
        viewModel.postData.accept(postData)
    }
}

extension StyleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getcommnetsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
        cell.layoutIfNeeded()
        guard let data = viewModel.getcommnet(indexPath.row) else { return UITableViewCell() }
        let size = cell.profileImageView.frame.size
        cell.setData(size: size, data: data)
        
        return cell
    }
    
    
}
