//
//  ImagePickerHandler_EditProfile.swift
//  StylezUser
//
//  Created by abcd on 25/03/2024.
//

import Foundation
import UIKit


//MARK: - image picker
extension EditProfileViewController{
    
    func presentImagePicker(){
        let alertController = UIAlertController(title: ""
                                                , message: "", preferredStyle: .actionSheet)
        
        let Camera = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "use_camera", comment: "")
                                   , style: .default) { action in
            
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "" , message: "CameraNotFound", preferredStyle: .alert)
                let OkButton = UIAlertAction(title: "Ok",style: .cancel) { (alert) -> Void in
                }
                alert.addAction(OkButton)
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        let Gallery = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "use_gallery", comment: "")
                                    , style: .default){ action in
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                    self.imagePicker.allowsEditing = false
                    self.present(self.imagePicker, animated: true, completion: nil)
                    
                }            }else
            {
            let alert = UIAlertController(title: "", message: "Can'tLocatePhotoLibrary", preferredStyle: .alert)
            let OkButton = UIAlertAction(title: "Ok",style: .cancel) { (alert) -> Void in
                    }
                    alert.addAction(OkButton)
                    self.present(alert, animated: true, completion: nil)
                }
        }
        let Cancel = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: "")
                                   , style: .default)
        alertController.addAction(Camera)
        alertController.addAction(Gallery)
        alertController.addAction(Cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            imgUser.image = image
            imageSelected = true
            
            DispatchQueue.main.async {
                self.doUploadImage(img: image)
            }
        }
        else if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage{
            imgUser.image = image
            imageSelected = true
            self.doUploadImage(img: image)
        }
        else{
            //print("error")
        }
        picker.dismiss(animated: true, completion: nil);
    }
    
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}
