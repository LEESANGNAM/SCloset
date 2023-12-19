//
//  ProfileEditViewController.swift
//  SCloset
//
//  Created by 이상남 on 12/18/23.
//

import UIKit
import PhotosUI

class ProfileEditViewController: BaseViewController {
    
    let mainView = ProfileEditView()
    var picker: PHPickerViewController!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImageViewTapGesture()
        setPHPicker()
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
//                    if let imageData = (image as? UIImage)?.jpegData(compressionQuality: 0.5) {
//                        self?.viewModel.setImageData(imageData)
//                    }
//                    self?.mainView.plusImageView.isHidden = true
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
    }
    
}
