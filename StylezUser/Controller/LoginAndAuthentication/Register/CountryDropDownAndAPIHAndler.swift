//
//  CountryDropDownAndAPIHAndler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/27/24.
//

import Foundation
import UIKit
import DropDown
import StylesWebKit


//MARK: - fetching country data and handling country dropdown
extension RegisterViewController{
    
    func getCountry2(){
        let loadingIndicator = getIndicator(controller: self)
        self.countries.removeAll()
        
        let resource = GetCountryResource()
        resource.getCountryList { result, errorMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
               
                if errorMsg == nil, let countries = result{
                    self.countries = countries
                }
                else{
                    //print("in country api response \(errorMsg)")
                }
            }
        }
    }
    
    func configCountryDown(sender:UIButton){
        let dropDown = DropDown()
        
        var names = [Countrys]()
        
        for all in countries{
            let name = all.name
            names.append(all)
        }
        
        dropDown.anchorView = sender // UIView or UIBarButtonItem
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
          
            txtNationality.text = item
            
            if self.countries.count > index {
                countryId = self.countries[index].id ?? 0
            }
            
            //print(countryId)
        }
        
        dropDown.show()
    }
}
