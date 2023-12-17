//
//  MyPostViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit

class MyPostViewController: BaseViewController {
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
    }
    
    private func setCollectionViewLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        // 전체 너비 가져와서 빼기
        let width = UIScreen.main.bounds.width - (spacing * 4)
        let itemWidth = width / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.3)
        //컬렉션뷰 inset
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
        // 최소 간격
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
}

extension MyPostViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCollectionViewCell.identifier, for: indexPath) as? PostImageCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
