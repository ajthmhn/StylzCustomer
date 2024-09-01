//
//  APIHandler_search.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import StylesWebKit
import UIKit

//MARK: - get employee
extension SearchViewController{
    
    func getEmployees(){
        employeeList.removeAll()
        
        let loadingIndicator = getIndicator(controller: self)
        
        let gender = getGenderCode()
        
        let lat = String(format:"%f",latitude ?? 0.0)
        let long = String(format:"%f", longitude ?? 0.0)
        
        
        let request = GetEmployeesRequest(lat: lat, lon: long, gender: gender,branchId: nil,serviceID: nil, employeeID: nil)
        
        let resource = GetEmployeesResources()
        resource.getEmployees(request: request) { employeeList in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if let employeeList{
                    self.employeeList = employeeList
                    self.mainEmployeeList = employeeList
                }
                self.updateEmployeeView()
            }
        }
        
    }
    
    func updateEmployeeView(){
        self.colStylists.reloadData()
        
        let label = getNoDataLabel(tableORColView: self.colStylists)
        
        if self.employeeList.count == 0{
            self.colStylists.backgroundView = label
        }else{
            self.colStylists.backgroundView = nil
        }
        
    }
}


//MARK: - get data
extension SearchViewController{
   
    func getSearchedData(){
        let loadingIndicator = getIndicator(controller: self)
        //print("fetching dataaa")
        
        var search_term = txtSearch.text ?? ""
       
        
        if (txtSearch.text?.isEmptyOrWhitespace() == true){
         search_term = ""
        }
        
        let gender = getGenderCode()
        let lat = String(format:"%f",latitude ?? 0.0)
        let long = String(format:"%f", longitude ?? 0.0)
     
        let searchType = [K.SearchTypes.shop, K.SearchTypes.employee]
        
        
        self.salons.removeAll()
        self.serviceList.removeAll()
        self.employeeList.removeAll()
        
        //print("seaarch term: \(search_term)")
        
        StylzAPIFacade.shared.searchAll(searchTerm: search_term, gender: gender, searchType: searchType,lat: lat,long: long){ (aRes) in
            //print("seaarch data: \(aRes?.json)")
           
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if aRes?.statusCode == 200{
                    if aRes?.json?["status"].intValue == 200{
                        
                    //if let data = aRes?.json?["data"].array{
                        if let all = aRes?.json?["data"].dictionary{
                //            for all in data{
                                
                        if let salons = all["shops"]?.array{
                                for m in salons{
                                    let booking = Salons(json: m)
                                    self.salons.append(booking)
                                }
                            }
                            
                            if let salons = all["services"]?.array{
                                for m in salons{
                                    let booking = Services(json: m)
                                    self.serviceList.append(booking)
                                }
                            }
                            
                            if let salons = all["employees"]?.array{
                                for m in salons{
                                    let booking = Employee(json: m)
                                    self.employeeList.append(booking)
                                }
                            }
                        
                           //      }
                    }
                    }else{
                       // showAlert(title: "", subTitle:  getErrMsg(json: aRes?.json) , sender: self)
                    }
                }
                else{
                  //  showAlert(title: "", subTitle:  getErrMsg(json: aRes?.json) , sender: self)
                    
                }
                
                self.updateSearchedData()
            }
        }
    }
    
    
    func updateSearchedData(){
        let label = self.getNoDataLabel(tableORColView:self.tblSearch)
        
        if self.salons.count == 0 && self.serviceList.count == 0 && self.employeeList.count == 0{
            //print("no data ")

            self.tblSearch.backgroundView = label
        }else{
            self.tblSearch.backgroundView = nil
        }
        //print("updating view")
        self.tblSearch.reloadData()
    }
    
}
