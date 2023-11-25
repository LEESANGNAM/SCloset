//
//  HomeViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import UIKit

class HomeViewController: BaseViewController {
    lazy var collectionView:  UICollectionView = {
            let cv = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
            cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
            cv.backgroundColor = .white
            return cv
        }()
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        setCollectionView()
    }
   
    private func setCollectionView(){
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
   private func setCollectionViewLayout() -> UICollectionViewFlowLayout{
            let layout = UICollectionViewFlowLayout()
            let spacing: CGFloat = 10
            // 전체 너비 가져와서 빼기
            let width = UIScreen.main.bounds.width - (spacing * 3)
            let itemSize = width / 2
       layout.itemSize = CGSize(width: itemSize, height: itemSize * 1.8)
            //컬렉션뷰 inset
            layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: 0, right: spacing)
            // 최소 간격
            layout.minimumLineSpacing = spacing
            layout.minimumInteritemSpacing = spacing
            return layout
        }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell()}
        
        return cell
    }
    
    
}
