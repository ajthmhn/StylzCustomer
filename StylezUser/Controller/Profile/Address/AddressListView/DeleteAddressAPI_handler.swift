//
//  DeleteAPI_handler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/5/24.
//

import Foundation
import UIKit


//MARK: - delete btn Alert
extension AddressViewController{
    
    func deleteAddress(index:Int){
        let alertController = UIAlertController(title: "", message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "delete_address", comment: ""), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.deleteAddress2(id: self.addressList[index].id ?? 0)
        }
        
        let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        
        alertController.addAction(okAction)
        
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}


//MARK: - delete api
extension AddressViewController
{
    
    func deleteAddress2(id:Int){
        let loadingIndicator = self.getIndicator(controller: self)
        
        let request = DeleteAddressRequest(id: id)
        
        let viewModel = DeleteAddressViewModel()
        viewModel.deleteAddress(request: request) { err in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if err != nil{
                    showAlert(title: "", subTitle: err!, sender: self)
                }
                else{
                    if selectedAddressId == id{
                     //   self.deleteConstantsValues() - pending
                    }
                    
                    self.getData2()
                }
            }
        }
    }
    
    func deleteConstantsValues(){
        addressSelected = false
        latitude =  0.0
        longitude =  0.0
        userAddress =  ""
        selectedAddressId = 0
    }

}

