//
//  SalonsView_Celll.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation
import UIKit
//MARK: - SalonsViewController

extension SalonListCell{
    
    func configSalon(){
        
        guard let salon = salon else {return}
        
        configSalonUI()
        setSalonLabels()
        setSalonImages()
    }
    
    func setSalonLabels(){
        if let salon{
            lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? salon.name_ar :  salon.name_en
            lblStar.text = "\(salon.salon_rating ?? 0.0)"
            lblAddress.text = salon.invoice_address
        }
    }
    
    func configSalonUI(){
          lblStar.textColor = getThemeColor()
          imgStar.tintColor = getThemeColor()
             viewBg.layer.cornerRadius = 20
          viewBg.layer.masksToBounds = true
          viewBg.layer.borderColor = UIColor.lightGray.cgColor
          viewBg.layer.borderWidth = 1
    }
    
    func setSalonImages(){
      if let salon, salon.salon_images.count > 0{
          setImage(imageView: imgshop, url: salon.salon_images[0],placeHolderImg: K.placeHolderImage.service )
        }else{
           imgshop.image = UIImage(named: "test_2")
        }
    }
}
