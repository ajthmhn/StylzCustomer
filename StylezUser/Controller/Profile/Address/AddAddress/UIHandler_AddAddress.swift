//
//  UIHandler_AddAddress.swift
//  StylezUser
//
//  Created by MACBOOK on 3/4/24.
//

import Foundation
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import UIKit
import GoogleMaps
import GooglePlaces


//MARK: - handling ui
extension AddAddressViewController{
    
    
    
    
    func addSearchBar(){
        self.viewSearch.addSubview(searchBar)
        searchBar.frame = self.viewSearch.bounds
        searchBar.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "all_barber", comment: "")
        searchBar.showsCancelButton = false
        searchBar.sizeToFit()
        searchBar.delegate = self
    }
    
    func configSearchBar(){
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.lightGray
            }
        }

        self.locationManager.requestAlwaysAuthorization()
        
        //Configuring map view
        configMapView()
      
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = UIColor.white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = UIImage(named: "location_address")
                leftView.tintColor = UIColor.lightGray
            }
        }
            
    }
    
    func setThemeColor(){
        btnAdd.backgroundColor = getThemeColor()
        btnBAck.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
       btnBAck.tintColor = getThemeColor()   
    }
    
  
    func setDesign(){
        if homeView == nil{
            viewNickName.isHidden = false
        }else{
            viewNickName.isHidden = true
            btnAdd.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "update_address", comment: ""), for: .normal)}
        
        localizeTextFiledText()
        
        setTextfieldDesign(text: txtNickName)
    }
    
    
    func localizeTextFiledText(){
        
        txtNickName.attributedPlaceholder = setRequired(placeHolder: LocalizationSystem.sharedInstance.localizedStringForKey(key: "nick_name", comment: ""))
        
        txtNickName.label.attributedText = setRequired(placeHolder: LocalizationSystem.sharedInstance.localizedStringForKey(key: "nick_name", comment: ""))
    }
    
    func setRequired(placeHolder:String) -> NSMutableAttributedString{
        let text = placeHolder
        let ranges = (text as NSString).range(of: "*")
        let attributedString = NSMutableAttributedString(string:text)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: ranges)
        return attributedString
    }
    
    func setTextfieldDesign(text:MDCOutlinedTextField){
        text.setNormalLabelColor(UIColor.lightGray, for: .normal)
        text.setFloatingLabelColor(UIColor(hexString: "143659")!, for: .editing)
        text.setOutlineColor(UIColor.lightGray, for: .normal)
        text.setOutlineColor(UIColor(hexString: "143659")!, for: .editing)
    }
    
    func addPlacesTableView(){
        tableDataSource = GMSAutocompleteTableDataSource()
        tableDataSource.delegate = self
        
        tableView = UITableView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.height - 450))
        tableView.delegate = tableDataSource
        tableView.dataSource = tableDataSource
        tableDataSource.tableCellBackgroundColor = UIColor.white
        
        view.addSubview(tableView)
        tableView.isHidden = true
        tableView.backgroundColor = UIColor.white
    }
}

