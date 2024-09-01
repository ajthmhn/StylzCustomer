//
//  EditProfileDropDown.swift
//  StylezUser
//
//  Created by MACBOOK on 3/3/24.
//

import Foundation
import DropDown
import StylesWebKit

//MARK: - country drop down
extension EditProfileViewController{
    
    // not using
    @objc func textFieldDidChange(textField : UITextField){
        let dropDown = DropDown()
        
        if textField.text?.count ?? 0 > 2{
            var names = [Countrys]()
            
            for all in countries{
                let name = all.name?.lowercased()
                let search = textField.text?.lowercased()
                if (name!.contains(search!)){
                    names.append(all)
                }
            }
            dropDown.anchorView = textField // UIView or UIBarButtonItem
            var titles = [String]()
            for all in names{
                titles.append(all.name ?? "")
            }
            
            dropDown.dataSource = titles
            dropDown.dismissMode = .automatic
            dropDown.selectRows(at: [countryId])
            
            DropDown.appearance().textColor = UIColor.lightGray
            DropDown.appearance().backgroundColor = UIColor.white
            DropDown.appearance().selectedTextColor = UIColor.black
            DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
            DropDown.appearance().selectionBackgroundColor = UIColor.white
            DropDown.appearance().cellHeight = 60
            DropDown.appearance().cornerRadius = 20
            
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                
                if self != nil {
                    txtCountry.text = item
                    countryId = index
                }
            }
            dropDown.show()
        }else{
            dropDown.hide()
        }
    }
}

