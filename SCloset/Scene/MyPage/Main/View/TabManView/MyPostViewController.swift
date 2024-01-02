//
//  MyPostViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/16/23.
//

import UIKit
import RxCocoa
import RxSwift

class MyPostViewController: BaseViewController {
    lazy var collectionView:  UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        cv.register(PostImageCollectionViewCell.self, forCellWithReuseIdentifier: PostImageCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = MyPostViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        bind()
        
    }
    private func setCollectionView() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        let input = MyPostViewModel.Input(viewWillAppear: self.rx.viewWillAppear.map { _ in })
        let output = viewModel.transform(input: input)
        
        output.postData
            .bind(with: self) { owner, _ in
                owner.collectionView.reloadData()
            }.disposed(by: disposeBag)
        
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
        return viewModel.getPostCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostImageCollectionViewCell.identifier, for: indexPath) as? PostImageCollectionViewCell else { return UICollectionViewCell() }
        let data = viewModel.getPostData(index: indexPath.row)
        cell.setData(data.toPostInfo())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewModel.getPostData(index: indexPath.row)
        let vm = StyleDetailViewModel()
        vm.postData.accept(data.toPostInfo())
        let vc = StyleDetailViewController(viewModel: vm)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .overFullScreen
        present(nav, animated: true, completion: nil)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height

            if offsetY > contentHeight - height {
                print("내 포스트 컬렉션 뷰 바닥임!")
                
                if !viewModel.getCursor().isEmpty {
                    viewModel.myPostLoad()
                }
            }
        }
}


