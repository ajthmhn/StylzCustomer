//
//  PlaceOrderRequest.swift
//  StylezUser
//
//  Created by abcd on 01/04/2024.
//

import Foundation
import StylesWebKit


struct PlaceOrderRequest {
    
    let referenceId:String
    
    //let paidAmount:String
    let payment_id:String
    let transaction_id:String
    
    //let payment_type:Int
    
    func getRequestBody() -> [String:Any]{
        
        var details = [String:Any]()
        
        details["reference_id"] = referenceId
        
        
        //details["paid_amount"] = paidAmount
        
        
        if payment_id != ""{
            details["payment_id"] = payment_id
        }
        if transaction_id != ""{
            details["transaction_id"] = transaction_id
        }
        
        
        // details["payment_type"] = 1
        return details
        
    }
    
}
