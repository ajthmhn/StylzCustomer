//
//  UIHandler_SelectionOptionsViewController.swift
//  StylezUser
//
//  Created by MACBOOK on 3/6/24.
//

import Foundation
import UIKit

//MARK: - generalized functions for both language and gender
extension SelectOptionsViewController{
   
    //general
    func setViewForTheOptedCase( ){
        
        let hideLang = isGender ? true : false
        let hideGender = isGender ? false : true
        
        for all in viewGenderBase{
            all.isHidden = hideGender
        }
        for all in viewLanguageBase{
            all.isHidden = hideLang
        }
    }
    
    func setImgs(tag:Int, imgViewArray:[UIImageView]){
        
        let themeImg = isFemale ? "circle_sel_girl" : "circle_sel_boy"
        
        for i in 0...imgViewArray.count-1{
            (i == tag) ?
            (imgViewArray[i].image = UIImage(named: themeImg))
            :
            (imgViewArray[i].image = UIImage(named: "circle_unsel"))
        }
    }
    
    func setViewForTheOptedCase(tag:Int, viewArray:[UIView], color:UIColor){
        
        for i in 0...viewArray.count-1{
            viewArray[i].layer.borderWidth = 1
            viewArray[i].layer.cornerRadius = 20
            viewArray[i].layer.masksToBounds = true
            
            if ( tag == i ){
                viewArray[i].layer.borderColor = color.cgColor
            }
            else{
                viewArray[i].layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor}
        }
    }
}

//MARK: -
extension SelectOptionsViewController{
  
    //MARK: - lanaguage
 
    func localiseTextAndSetThemeColor(){
        
        btnSelect.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update", comment: ""), for: .normal)
        
        lblMale.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "male", comment: "")
        
        lblFemale.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "female", comment: "")
    }
    
    func updateLanguageView(tag:Int){
        setViewForTheOptedCase(tag: tag, viewArray: viewLanguage, color: getThemeColor())
        
        setImgs(tag: tag, imgViewArray: imgLanguage)
        
        btnSelect.backgroundColor = getThemeColor()
    }
    
    func configLanguageView(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_language", comment: "")
        
        let tag = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? 0 : 1
        
        self.updateLanguageView(tag: tag)
    }
    
    //MARK: - gender
    func updateGenderView(tag:Int){
        let themeColor = (tag == 0 ? maleColor : femaleColor)!
        
        setViewForTheOptedCase(tag: tag, viewArray: viewGender, color: themeColor)
        
        setImgs(tag: tag, imgViewArray: imgGender)
        
        btnSelect.backgroundColor = themeColor
    }
    
    func configGenderView(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "selct_gender", comment: "")
        
        let tag = isFemale ? 1 : 0
        
        self.updateGenderView(tag: tag)
    }
}
