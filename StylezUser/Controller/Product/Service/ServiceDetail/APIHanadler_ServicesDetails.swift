//
//  APIHanadler_ServicesDetails.swift
//  StylezUser
//
//  Created by abcd on 31/03/2024.
//

import Foundation

//MARK: -  get employees //5
extension ServiceDetailsViewController{
    
    func getEmployees(){
        self.employeeArraay.removeAll()
        
        let loadingIndicator = self.getIndicator(controller: self)
        let gender = getGenderCode()
        
        let selectedServiceID = selectedService?.id ?? 0
        
        //branch = 1, empployee = 2, services = 3
        let request = GetEmployeesRequest(lat: "", lon: "", gender: gender, branchId: branchID, serviceID: selectedServiceID, employeeID: nil)
        
        let resource = GetEmployeesResources()
        resource.getEmployees(request: request) { employees in
            
            DispatchQueue.main.async {
                
                loadingIndicator.removeFromSuperview()
              
                if let employees{
                    self.employeeArraay = employees
                }
                self.updateEmployeeView()
            }
        }
    }
    
    func updateEmployeeView(){
        self.detailsCollectionVieew.reloadData()
        
        let label = getNoDataLabel(tableORColView: detailsCollectionVieew)
        
        if self.employeeArraay.count == 0{
                self.detailsCollectionVieew.backgroundView = label
        }else{
            self.detailsCollectionVieew.backgroundView = nil
        }
    }
    
}
//
//
////MARK: -  get services //5
//extension ServiceDetailsViewController{
//    
//    func getServices(){
//        
//        self.employeeArraay.removeAll()
//        
//        let loadingIndicator = self.getIndicator(controller: self)
//        let gender = self.getGenderCode()
//        
//        let request = GetServicesRequest(salon_Id: salon?.id ?? 0, categoryId: selectedCategoryID, employeeID: nil, gender: gender)
//        
//        let resource = GetMyServiceResource()
//        resource.getServices(request: request) { services in
//            
//            DispatchQueue.main.async {
//                
//                loadingIndicator.removeFromSuperview()
//                
//                if let services{
//                    self.services = services
//                }
//                //print("services count \(self.services)")
//                self.updateServicesView()
//            }
//        }
//    }
//}
