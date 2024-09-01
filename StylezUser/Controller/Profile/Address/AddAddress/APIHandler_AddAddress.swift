//
//  APIHandler_AddAddress.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation

//MARK: - add address api
extension AddAddressViewController{
    
    func updateAddressConstants(){
        if self.isAddingFromHome == true{
            addressSelected = true
            latitude = self.countryLatitude ?? 0.0
            longitude = self.countryLongitude ?? 0.0
            userAddress = self.txtNickName.text ?? ""
        }
    }
    
    func popView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addAddress2(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let lat = String(format:"%f", self.countryLatitude ?? 0.0)
        let long = String(format:"%f", self.countryLongitude ?? 0.0)
      
        let nickName = self.txtNickName.text ?? ""
        
        let request = AddAddressRequest(_latitude: lat, _longitude: long, nickName: nickName)
        
        //print(request)
        
        let viewModel = AddAddressViewModel()
        viewModel.createAddress(request: request) { err in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if err != nil{
                    showAlert(title: "", subTitle:  err! , sender: self)
                }
                else{
                    showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "address_added", comment: ""), view: self.view)
                    
                    self.updateAddressConstants()
                    
                    self.popView()
                }
            }
        }
    }
}
