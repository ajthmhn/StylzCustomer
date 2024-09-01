//
//  GetAddressAPI_handler.swift
//  StylezUser
//
//  Created by MACBOOK on 3/5/24.
//

import Foundation
import UIKit


//MARK: - get Address api
extension AddressViewController{
   
    func getData2(){
        self.addressList.removeAll()
      
        let activityIndicator = self.getIndicator(controller: self)
        
        let resource = GetAddressDataResource()
        resource.addressList { addressData in
          
            DispatchQueue.main.async {
            
                activityIndicator.removeFromSuperview()
                
                if let addressData{
                    self.addressList = addressData}
                self.updateAddressView()
            }
        }
    }
    
    func updateAddressView(){
        self.tblAddress.reloadData()
        
        let label = getNoDataLabel(tableORColView: self.tblAddress)
       
        if self.addressList.count == 0{
            self.tblAddress.backgroundView = label
        }else{
            self.tblAddress.backgroundView = nil
        }
    }
    
   }

