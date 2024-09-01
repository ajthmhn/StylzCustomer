//
//  GetCountryResource.swift
//  StylezUser
//
//  Created by MACBOOK on 2/21/24.
//

import Foundation
import StylesWebKit

struct GetCountryResource{
    
    func getCountryList(completionHandler:@escaping (_ result: [Countrys]?, _ errorMsg: String?)->()) {
        
        var countries = [Countrys]()
        
        StylzAPIFacade.shared.getCountry { (aRes) in
            
            
            //print(aRes?.json)
         //   //print(aRes?)
           
            if aRes?.statusCode == 200{
              //  if aRes?.json?["status"].boolValue == true{
                    //                    if let data = aRes?.json?["data"].array{
                    //                        for m in data{
                    //                            let booking = Countrys(json: m)
                    //                            countries.append(booking)
                    //                        }
                    //
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(CountryResponseModel.self, from: (aRes?.data)!)
                        //print("data decoded \(decodedData)")
                        completionHandler(decodedData.countries, nil)
                    }
                    catch let error{
                       // //print("error occured while decoding = \(error.localizedDescription)")
                     
                        completionHandler(nil,LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") )
                    }
            }else{
                completionHandler(nil,LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.someThingWentWrong, comment: "") )
            }
        }
        
    }
    
}

