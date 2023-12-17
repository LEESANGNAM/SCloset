//
//  MyLikePostViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit
import RxCocoa
import RxSwift

class MyLikePostViewController: BaseViewController {
    let disposeBag = DisposeBag()
    lazy var collectionView:  UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        cv.register(PostImageCollectionViewCell.self, forCellWithReuseIdentifier: PostImageCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
//        cv.prefetchDataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    override func viewDidLoad() {
       
        view.addSubview(collectionView)
        view.backgroundColor = .white
       
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview()
        }
        
        test()
    }
    
    private func test() {
        let likepostTest = NetworkManager.shared.request(type: PostLoadResponseModel.self, api: .myLikePost(next: "", limit: "10"))
        likepostTest.subscribe(with: self) { owner, value in
            print("좋아요 게시글 ",value)
        } onError: { owner, error in
            if let networkError = error as? NetWorkError {
                let errorText = networkError.message()
                      print(errorText)
            }
        } onCompleted: { _ in
            print("좋아요 게시글 완료")
        } onDisposed: { _ in
            print("좋아요 게시글 디스포즈")
        }.disposed(by: disposeBag)

        
    }
    
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        // 전체 너비 가져와서 빼기
        let width = UIScreen.main.bounds.width - (spacing * 3)
        let itemWidth = width / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.2)
        //컬렉션뷰 inset
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        // 최소 간격
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
}

extension MyLikePostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCollectionViewCell.identifier, for: indexPath) as? PostImageCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
