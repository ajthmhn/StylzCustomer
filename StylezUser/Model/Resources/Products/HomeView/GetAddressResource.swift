////
////  getAddressResource.swift
////  StylezUser
////
////  Created by mac on 12/03/2024.
////
//
//import Foundation
//import StylesWebKit
//
//struct GetAddressResource{
//    
//    func addressList(completionHandler:@escaping (_ addressList: [Addresss]?)->()) {
//        
//        StylzAPIFacade.shared.addressList{ (aRes) in
//            
//            if aRes?.statusCode == 200{
//                var addressList = [Addresss]()
//                if let data = aRes?.json?["data"].array{
//                    for m in data{
//                        let booking = Addresss(json: m)
//                        addressList.append(booking)
//                    }
//                }
//                completionHandler(addressList)
//            }
//            else{
//                completionHandler(nil)
//            }
//            
//        }
//    }
//}
