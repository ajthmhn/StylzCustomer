//
//  APIHandler_CategoryViewController.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import Foundation



extension CategoryViewController{
    
    func getCategory(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        let gender = getGenderCode()
        
        //1 for gender //2 for branch id //3 for employee id
        let request = CategoryRequest(gender: gender, keyValue: nil,filterWithbranch: false)
        
        let resource = CategeoryResource()
        resource.getCategory(request: request) { categories, errorMsg in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle:  errorMsg! , sender: self)
                }
                else{
                    if let categories{
                        self.categories = categories
                    }
                    
                    self.updateCateoryTable()
                }
            }
        }
    }
    
    
    func updateCateoryTable(){
        self.tblList.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblList)
        
        if self.categories.count == 0{
            self.tblList.backgroundView = label
        }else{
            self.tblList.backgroundView = nil
        }
    }
    

}
