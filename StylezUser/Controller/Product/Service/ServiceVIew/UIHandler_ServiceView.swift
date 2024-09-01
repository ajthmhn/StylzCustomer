//
//  UIHandler_ServiceView.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation
import StylesWebKit
import ImageSlideshow


////MARK: - check if fav
//extension ServiceViewController{
//
//    func checkAndSetFav(){
//        if let salon{
//            salon.is_favorite ?? false ?
//            (favStatus = 0) : (favStatus = 1)
//        }
//        //print("is fav = \(salon?.is_favorite), favStatus: \(favStatus)")
//
//        updateFavImgAndShowAlert(showAlert: false)
//    }
//
//}

//MARK: - ui setup and localization
extension ServiceViewController{
    
    func setUpUI(){
        self.tblServicew.backgroundView = nil
        
        for all in imgTabs{
            all.setImageColor(color: UIColor.darkGray)
        }
        for all in lblTabs{
            all.textColor = UIColor.darkGray
        }
        
        imgTabs[0].setImageColor(color: getThemeColor())
        lblTabs[0].textColor = getThemeColor()
        viewCart.backgroundColor = getThemeColor()
        
        lblCount.textColor = getThemeColor()
        lblCount.layer.cornerRadius = 5
        lblCount.layer.masksToBounds = true
        lblCart.clipsToBounds = true
        
        viewCart.isHidden = true
        viewCart.backgroundColor = getThemeColor()
        bottomSpace.constant = 0
        
        //getting attributed string from a separate func
        lblCart.attributedText = getAttributedString()
     
        starImg.tintColor = getThemeColor()
        shareImg.tintColor = getThemeColor()
    }
    
    
    
    //localization
    func localizeText(){
        lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? salon?.name_ar : salon?.name_en
        
        
        lblService.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "services", comment: "")
        lblOffer.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "special_offer", comment: "")
        lblEmployee.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "employee", comment: "")
    }
    
}

//MARK: - image sliders
extension ServiceViewController{
    
    func addImageSlider(){
        var bannerImageList = [AlamofireSource]()
        for all in salon?.salon_images ?? []{
            let imageURl =  AlamofireSource(urlString:all)
            if imageURl != nil{
                bannerImageList.append(imageURl!)
            }
        }
        
        if bannerImageList.count == 0{
            self.slider.setImageInputs([ImageSource(image: UIImage(named: "test_2")!)])
        }else{
            self.slider.setImageInputs(bannerImageList)
        }
        
        self.slider.slideshowInterval = 5.0
        self.slider.contentScaleMode = .scaleAspectFill
        self.slider.pageIndicator = nil
    }
}
