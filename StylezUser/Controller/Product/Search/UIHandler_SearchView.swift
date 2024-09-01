//
//  UIHandler_SearchView.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit

//MARK: - ui
extension SearchViewController{

    func localizeSearchbar(){
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            txtSearch.textAlignment = .right
        }else{
            txtSearch.textAlignment = .left
        }
       
    }
    
    func configView(){
        if isStylist == false{
        configEmployeeView()
        }else{
        configSearchView()
        }
    }
    
    func configEmployeeView(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search", comment: "")
        txtSearch.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search_hair", comment: "")
        colStylists.isHidden = true
        tblSearch.isHidden = false
     
       // searchView.isHidden = true
        //searchViewHeight.constant = 0
    }
   
    func configSearchView(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "stylist", comment: "")
        txtSearch.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "search", comment: "")
        
        colStylists.isHidden = false
        tblSearch.isHidden = true
    
      //  searchView.isHidden = false
       // searchViewHeight.constant = 50
    }
   
    func configTF(){
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
}


    //MARK: - textfield delegate
extension SearchViewController:UITextFieldDelegate{
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        (isStylist == false) ?
        getSearchedData() : filterData()
        
        return true
    }
    
    @objc func textFieldDidChange(textField : UITextField){
        // fetchData(getOnlyClients: true )
        
        //textField.resignFirstResponder()
        
        //print("text \(textField.text)")
        
        (isStylist == false) ?
        getSearchedData() : filterData()
        
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()     
    }
    
}



//MARK: - filter data
extension SearchViewController{
    
    
    func filterData(){
        
        if ((txtSearch.text?.isEmptyOrWhitespace()) == true){
          employeeList = mainEmployeeList
        }
        else{
            employeeList = mainEmployeeList.filter { $0.first_name?.lowercased().contains(txtSearch.text?.lowercased() ?? "") ?? false }
        }
        
        
        self.updateEmployeeView()
  
    }
}

