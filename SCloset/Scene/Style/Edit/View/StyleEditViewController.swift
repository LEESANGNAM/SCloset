//
//  StyleViewController.swift
//  SCloset
//
//  Created by 이상남 on 11/27/23.
//

import UIKit
import PhotosUI
import Toast
import RxSwift
import RxCocoa

class StyleEditViewController: BaseViewController {
    let mainView = StyleEditView()
    let viewModel: StyleEditViewModel
    let disposeBag = DisposeBag()
    var doneButton: UIBarButtonItem!
    var picker: PHPickerViewController!
    init(viewModel: StyleEditViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneButton()
        setupToolbar()
        setcontenView()
        setPHPicker()
        setImageViewTapGesture()
        bind()
    }
    
    private func bind() {
        let input = StyleEditViewModel.Input(
            viewDidLoad: Observable.just(()),
            titleTextfieldChange: mainView.titleTextField.rx.text.orEmpty,
            contentTextViewChange: mainView.contentTextView.rx.text.orEmpty,
            contentTextViewDidBeginEditing:mainView.contentTextView.rx.didBeginEditing,
            contentTextViewDidEndEditing: mainView.contentTextView.rx.didEndEditing,
            doneButtonTapped: doneButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        output.errorMessage
            .bind(with: self) { owner, text in
                owner.view.makeToast(text, position: .top)
            }.disposed(by: disposeBag)
        
        output.locationMessage
            .bind(to: mainView.locationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.contentTextViewDidBeginEditing
            .bind(with: self) { owner, _ in
                if owner.mainView.contentTextView.text == owner.viewModel.getPlaceHolder(){
                    owner.mainView.contentTextView.text = nil
                    owner.mainView.contentTextView.textColor = .black
                }
            }.disposed(by: disposeBag)
        
        output.contentTextViewDidEndEditing
            .bind(with: self) { owner, _ in
                if owner.mainView.contentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    owner.mainView.contentTextView.text = owner.viewModel.getPlaceHolder()
                    owner.mainView.contentTextView.textColor = .lightGray
                }
            }.disposed(by: disposeBag)
        
        output.postData
            .bind(with: self) { owner, postData in
                guard let postData else { return }
                owner.mainView.titleTextField.text = postData.title
                owner.mainView.contentTextView.text = postData.content
                owner.mainView.contentTextView.textColor = .black
                owner.doneButton.title = "수정"
            }.disposed(by: disposeBag)
        
        output.imageDataRelay
            .bind(with: self) { owner, data in
                guard let data else { return }
                owner.mainView.lookImageView.image = UIImage(data: data)
                owner.mainView.plusImageView.isHidden = true
            }.disposed(by: disposeBag)
        
        output.doneButtonTapped
            .bind(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
        
        
    }
    
    private func setcontenView(){
        mainView.contentTextView.text = viewModel.getPlaceHolder()
        mainView.contentTextView.textColor = .lightGray
    }
    private func setPHPicker(){
        var phPickerConfiguration = PHPickerConfiguration()
        phPickerConfiguration.filter = .any(of: [.images,.livePhotos])
        picker = PHPickerViewController(configuration: phPickerConfiguration)
        picker.delegate = self
    }
    
    private func setDoneButton(){
        doneButton = UIBarButtonItem(title: "등록", style: .done, target: self, action: nil)
        doneButton.tintColor = .black
        navigationItem.rightBarButtonItem = doneButton
    }
    private func setImageViewTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(lookImageViewTapped))
        mainView.lookImageView.isUserInteractionEnabled = true
        mainView.lookImageView.addGestureRecognizer(tapGesture)
    }
    @objc private func lookImageViewTapped(){
        print(#function)
        present(picker, animated: true)
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(toolbarDoneButtonTapped))
        
        toolbar.items = [flexibleSpace, doneBarButton]
        
        mainView.titleTextField.inputAccessoryView = toolbar
        mainView.contentTextView.inputAccessoryView = toolbar
    }
    
    @objc private func toolbarDoneButtonTapped() {
        view.endEditing(true)
    }
    
}

extension StyleEditViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        let itemProvider = results.first?.itemProvider // 2
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) {[weak self] (image, error) in // 4
                DispatchQueue.main.async { [weak self] in
                    if let imageData = (image as? UIImage)?.jpegData(compressionQuality: 0.5) {
                        self?.viewModel.setImageData(imageData)
                    }
                    self?.mainView.plusImageView.isHidden = true
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
    
}
