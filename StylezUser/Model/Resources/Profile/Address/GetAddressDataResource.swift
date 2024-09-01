//
//  GetAddressDataResource.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation
import StylesWebKit

struct GetAddressDataResource{
    
    func addressList(completionHandler:@escaping (_ addressData: [Addresss]?)->()) {
        
        StylzAPIFacade.shared.addressList{ (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    var addressList = [Addresss]()
                    if let data = aRes?.json?["address"].array{
                        for m in data{
                            let booking = Addresss(json: m)
                            addressList.append(booking)
                        }
                    }
                    completionHandler(addressList)
                    
                }else{
                    completionHandler(nil)
                }
            }
            else{
                completionHandler(nil)
                
            }
        }
    }
}
