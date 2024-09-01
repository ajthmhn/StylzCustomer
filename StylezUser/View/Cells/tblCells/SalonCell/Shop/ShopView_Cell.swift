//
//  ShopView_Cell.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation
import UIKit

//MARK: - ShopsViewController

extension SalonListCell{
    
    func configShopSalon(){
        
        guard let branch = branch else {return}
        
        configShopSalonUI()
        setShopSalonLabels()
        setBranchImagee()
    }
    
    func setShopSalonLabels(){
        if let branch{
            lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? branch.name_ar :  branch.name_en
            lblStar.text = "\(branch.salon_rating ?? 0.0)"
            lblAddress.text = branch.invoice_address
        }
    }
    
    func setBranchImagee(){
        if let branch, branch.salon_images.count > 0{
            setImage(imageView: imgshop, url: branch.salon_images[0],placeHolderImg: K.placeHolderImage.service )
        }else{
            imgshop.image = UIImage(named: "test_2")
        }
    }
    
    func configShopSalonUI(){
        lblStar.textColor = getThemeColor()
        imgStar.tintColor = getThemeColor()
        
        //viewBg.dropShadow(color: UIColor.lightGray)
        
        viewBg.layer.cornerRadius = 20
        viewBg.layer.masksToBounds = true
       
        self.dropShadow(color: UIColor.lightGray)
      
    }
}

