//
//  HomeViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/25/23.
//

import UIKit
import RxSwift
import RxCocoa


class StyleListViewController: BaseViewController {
    lazy var collectionView:  UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
        cv.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        cv.delegate = self
        cv.dataSource = self
        cv.prefetchDataSource = self
        cv.backgroundColor = .white
        return cv
    }()
    
    let viewModel = StyleListViewModel()
    let disposeBag = DisposeBag()
    var addbutton: UIBarButtonItem!
    override func viewDidLoad() {
        view.backgroundColor = .blue
        setCollectionView()
        setupSearchBar()
        setupRigthButton()
        bind()
    }
    
    private func bind() {
        let input = StyleListViewModel.Input(
            viewDidLoad: Observable.just(()),
            viewWillAppear: self.rx.viewWillAppear.map{_ in},
            addButtonTap: addbutton.rx.tap,
            cellTap: collectionView.rx.itemSelected,
            modelSelect: collectionView.rx.modelSelected(PostLoad.self)
        )
        let output = viewModel.transform(input: input)
        
        output.addButtonTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(StyleAddViewController(), animated: true)
            }.disposed(by: disposeBag)
        output.postData
            .bind(with: self) { owner, _ in
                owner.collectionView.reloadData()
            }.disposed(by: disposeBag)
        
    }
    
    
    private func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요"
        navigationItem.titleView = searchBar
    }
    private func setupRigthButton(){
        addbutton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        navigationItem.rightBarButtonItem = addbutton
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

extension StyleListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getPostCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell()}
        let data = viewModel.getPostData(index: indexPath.row)
        cell.setData(data: data)
        return cell
    }
    
    
    
}

extension StyleListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths{
            print(indexPath)
            print("커서값",viewModel.getCursor())
            if viewModel.getPostCount() - 4 == indexPath.row &&  !viewModel.getCursor().isEmpty {
                viewModel.postLoad()
            }
        }
    }
    
}
