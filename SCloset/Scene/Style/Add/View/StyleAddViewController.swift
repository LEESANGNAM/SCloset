//
//  StyleViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import UIKit

class StyleAddViewController: BaseViewController {
    let button = {
        let button = UIButton()
        button.setTitle("테스트으으으", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    let imageView = {
        let view = UIImageView()
        view.image = UIImage(named: "testImage")
        return view
    }()
    let viewModel = StyleAddViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    override func setConstraints() {
        view.addSubview(imageView)
        view.addSubview(button)
        
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(imageView.snp.bottom).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        
    }
    
    @objc func buttonTapped(){
        if let image = imageView.image,
           let data = image.jpegData(compressionQuality: 0.5){
            viewModel.postUpLoad(data: data)
        }
    }
    
}
