//
//  EmployeeCell.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit


//MARK: - ServiceViewController - Employee cell

extension ServiceListCell{
    
    
    func configEmployeeCell(){
        
        guard let employee = employee else {return}
        
        dropShadow(color: UIColor.lightGray)
        lblName.text =  employee.first_name
        lblDuration.text = employee.phone
        setImage(imageView: self.imgProduct, url: employee.image ?? "",placeHolderImg: nil)
        
        imgProduct.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
      
        lblPrice.text = employee.employee_rating
   
    }
}
