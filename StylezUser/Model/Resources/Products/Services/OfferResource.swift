//
//  OfferResource.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation

import StylesWebKit

struct OfferResource{
    
    func getOffers(request:GetOffersRequest,completionHandler:@escaping (_ services:  [Services]?)->()) {
        
        StylzAPIFacade.shared.getOffers(id: request.getRequestBody()) { (aRes) in
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].intValue == 200{
                    var offerList = [Services]()
                    if let data = aRes?.json?["discounts"].array{
                        for m in data{
                            let booking = Services(json: m)
                            offerList.append(booking)
                        }
                    }
                    completionHandler(offerList)
                }else{
                    completionHandler(nil)
                }
            }else{
                completionHandler(nil)
            }
        }
    }
}
