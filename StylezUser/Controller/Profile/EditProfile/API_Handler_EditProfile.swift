//
//  API_Handler_EditProfile.swift
//  StylezUser
//
//  Created by mac on 21/03/2024.
//

import Foundation
import UIKit

//MARK: - update profile api
extension EditProfileViewController{
    
    func updateProfile2(){
        
        let activityIndicator = getIndicator(controller: self)
        
        let request = UpdateProfileRequest(name: txtName.text ?? "", countryID: "\(self.countryId)", age: txtAge.text ?? "" , occupation: txtJob.text ?? "")
        
        //print(request)
        
        let resource = UpdateProfileResource()
        resource.updateProfile(request: request) { errorMsg in
            
            DispatchQueue.main.async {
                
                activityIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg! , sender: self)
                }
                else{
                    self.showAlertAndPopBack()
               }
            }
        }
    } 
 
    func showAlertAndPopBack(){
        let alertController = UIAlertController(title: "", message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "profile_updated", comment: "") , preferredStyle: .alert)
      
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
     
            self.navigationController?.popViewController(animated: false)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}


//MARK: - fetch user data
extension EditProfileViewController{
  
    func fetchCustomerInfo(){
        
        let loadingInicator = self.getIndicator(controller: self)
        
        let resource = GetCustomerInformation()
        resource.getCustomerInformation { err in
            
            DispatchQueue.main.async {
                
                loadingInicator.removeFromSuperview()
                //  self.showAlertAndPopBack()
                
                self.setUserImage()
                self.populateUserDetials()
                self.updateViewForVerifiedDetails()
            
            }
        }
    }
  }

//MARK: - upload image

extension EditProfileViewController{
    
    func doUploadImage(img:UIImage){
       
        let loadingIndicator = self.getIndicator(controller: self)
        
        let request = UploadProfileImageRequest(image: img)
      
        let resource = UploadProfileImageResource()
        resource.uploadImage(request: request) { errorMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.imageUploaded, comment: ""), view: self.view)
                }
            }
        }
    }    
}

