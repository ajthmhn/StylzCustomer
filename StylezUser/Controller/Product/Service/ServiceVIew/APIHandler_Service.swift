//
//  APIHandler_Service.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit
import StylesWebKit


//MARK: -  favourite
extension ServiceViewController{
    
    //MARK: - mark it  fav or  unFav    //1
    
    func makeThisSalonFavOrUnFav(){
        
        let gender = getGenderCode()
        
        let request  = MakeFavRequest(salon_Id: salon?.id ?? 0, gender: gender, favStatus: favStatus)
        
        let resource =  MakeFavouriteResource()
        resource.getEmployees(request: request) { success in
            //print("favstatus: \(self.favStatus),  makefav:  \(success)")
        }
    }
    
    //MARK: - check if Fav //2
    func checkIfFavourite(){
        
        let gender = getGenderCode()
        let request = CheckFavouriteRequest(id: salon?.id ?? 0, gender: gender)
        
        let viewModel = CheckFavouriteViewModel()
        
        viewModel.checkFavourite(request: request) { favCode, err in
            
            DispatchQueue.main.async {
                //print("is fav - \(favCode)")
                self.favStatus = favCode
                self.setFavImage()
            }
        }
    }
    
    func setFavImage(){
        self.favStatus == 1 ? (self.imgLike.image = UIImage(named: "like")) : (self.imgLike.image = UIImage(named: "unlike"))
    }
}


//MARK: - get offer //3
extension ServiceViewController{
    
    func getOffers(){
        offerList.removeAll()
        
        let request = GetOffersRequest(id: salon?.id ?? 0)
        
        let resource = OfferResource()
        
        resource.getOffers(request: request) { services in
            DispatchQueue.main.async {
                if let services{
                    self.offerList = services
                }
                self.updateServicesTable()
            }
        }
    }
    
    func updateServicesTable(){
        self.tblServicew.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblServicew)
        
        if self.offerList.count == 0{
            self.tblServicew.backgroundView = label
        }else{
            self.tblServicew.backgroundView = nil
        }
    }
    
}


//MARK: -  Category
extension ServiceViewController{
    
    
    func fetchData(getOnlyServices:Bool){
        
        dispatchGroup.enter()
        let loadingIndicator = getIndicator(controller: self)
        
        getOnlyServices ? getServices() : getCategory()
        
        dispatchGroup.notify(queue: .main) {
            
            loadingIndicator.removeFromSuperview()
            
            //print("services count \(self.services)")
            
            if getOnlyServices == false{
                self.colCategories.reloadData()
            }
            
            self.updateServicesView()
            
        }
    }
    
    
    
    
    func getCategory(){
        
        self.categories.removeAll()
        
        let gender = getGenderCode()
        
        //1 for gender //2 for branch id //3 for employee id
        let branceID = salon?.id ?? 0
        
        let request = CategoryRequest(gender: gender, keyValue: branceID,filterWithbranch: true)
        
        let resource = CategeoryResource()
        resource.getCategory(request: request) { categories, errorMsg in
            if let categories{
                self.categories = categories
                self.setSelectedCatIndex()
                self.getServices()
            }
            else{
                self.dispatchGroup.leave()
            }
            
        }
    }
    
    func setSelectedCatIndex(){
        if self.categories.count>0{
            selectedCategoryID = categories[0].id ?? 0
        }
    }
}


//MARK: - get services    //4
extension ServiceViewController{
    
    
    func getServices(){
        
        self.services.removeAll()
        
        let gender = self.getGenderCode()
        
        let request = GetServicesRequest(salon_Id: salon?.id ?? 0, categoryId: selectedCategoryID, employeeID: nil, gender: gender)
        
        let resource = GetMyServiceResource()
        resource.getServices(request: request) { services in
            
            if let services{
                self.services = services
            }
            
            self.dispatchGroup.leave()
        }
    }
    
    
    func updateServicesView(){
        //print("updatinng servicee viiew")
        self.tblServicew.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblServicew)
        
        if self.services.count == 0{
            //print("no data found")
            self.tblServicew.backgroundView = label
        }else{
            self.tblServicew.backgroundView = nil
        }
    }
}


//MARK: -  get employees //5
extension ServiceViewController{
    
    func getEmployees(){
        self.employeeList.removeAll()
        
        let gender = getGenderCode()
        
        
        let request = GetEmployeesRequest(lat:"", lon: "", gender: gender,branchId:self.salon?.id ?? 0,serviceID: nil,employeeID: nil)
        
        let resource = GetEmployeesResources()
        resource.getEmployees(request: request) { employees in
            
            DispatchQueue.main.async {
                if let employees{
                    self.employeeList = employees
                }
                self.updateEmployeeView()
            }
        }
    }
    
    func updateEmployeeView(){
        self.tblServicew.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblServicew)
        
        if self.employeeList.count == 0{
            if self.firsttime == false{
                self.tblServicew.backgroundView = label
            }
        }else{
            self.tblServicew.backgroundView = nil
        }
    }
}
