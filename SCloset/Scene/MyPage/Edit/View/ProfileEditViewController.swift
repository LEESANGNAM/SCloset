//
//  ProfileEditViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/18/23.
//

import UIKit
import PhotosUI
import RxSwift
import RxCocoa
import Toast

class ProfileEditViewController: BaseViewController {
    
    let mainView = ProfileEditView()
    let viewModel: ProfileEditViewModel!
    var doneButton: UIBarButtonItem!
    let dispostBag = DisposeBag()
    var picker: PHPickerViewController!
    
    init(viewModel: ProfileEditViewModel){
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
        setDoneButton()
        setImageViewTapGesture()
        setPHPicker()
        bind()
    }
    
    private func bind() {
        let input = ProfileEditViewModel.Input(
            viewDidLoad: Observable.just(()),
            nicknameTextfieldChange: mainView.nicknameTextField.rx.text.orEmpty,
            phoneNumTextfieldChange: mainView.phoneNumTextField.rx.text.orEmpty,
            birthDayTextfieldChange: mainView.birthdayTextField.rx.text.orEmpty,
            doneButtonTapped: doneButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.errorMessage
            .bind(with: self) { owner, text in
                owner.view.makeToast(text)
            }.disposed(by: dispostBag)
        
        output.imageDataValid
            .bind(to: doneButton.rx.isHidden)
            .disposed(by: dispostBag)
        
        output.profileImageData
            .bind(with: self) { owner, data in
                if let data {
                    owner.mainView.profileImageView.image = UIImage(data: data)
                }
            }.disposed(by: dispostBag)
        
        output.profile
            .bind(with: self) { owner, profile in
                if let profile {
                    owner.mainView.nicknameTextField.text = profile.nick
                    owner.mainView.phoneNumTextField.text = profile.phoneNum
                    owner.mainView.birthdayTextField.text = profile.birthDay
                    
                }
            }.disposed(by: dispostBag)
        
        output.netWorkSucces
            .bind(with: self) { owner, value in
                if value {
                    owner.navigationController?.popViewController(animated: true)
                }
            }.disposed(by: dispostBag)
        
        
    }
    
    private func setDoneButton(){
        doneButton = UIBarButtonItem(title: "수정", style: .done, target: self, action: nil)
        doneButton.tintColor = .black
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setImageViewTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lookImageViewTapped))
        mainView.profileImageView.isUserInteractionEnabled = true
        mainView.profileImageView.addGestureRecognizer(tapGesture)
    }
    @objc private func lookImageViewTapped(){
        print(#function)
        present(picker, animated: true)
    }
    private func setPHPicker(){
        var phPickerConfiguration = PHPickerConfiguration()
        phPickerConfiguration.filter = .any(of: [.images,.livePhotos])
        picker = PHPickerViewController(configuration: phPickerConfiguration)
        picker.delegate = self
    }
}

extension ProfileEditViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProvider = results.first?.itemProvider // 2
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in // 4
                DispatchQueue.main.async { [weak self] in
                    self?.mainView.profileImageView.image = image as? UIImage
                    if let imageData = (image as? UIImage)?.jpegData(compressionQuality: 0.5) {
                        self?.viewModel.setImageData(imageData)
                    }
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
    
}
