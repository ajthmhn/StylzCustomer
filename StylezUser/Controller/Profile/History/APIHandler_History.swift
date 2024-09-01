//
//  APIHandler_History.swift
//  StylezUser
//
//  Created by mac on 11/03/2024.
//

import Foundation

//MARK: - api
extension HIstoryViewController{
    
    func getOrderHistory(){
        
        let loadingIndicator = self.getIndicator(controller: self)
        
        self.orders.removeAll()
        
        let gender = checkIfNotMale() ? 2 : 1
        let request = HistoryRequest(gender: gender)
        
        let resource = HistoryResource()
        
        resource.orderHIstory(request: request) { appointments in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if appointments != nil, let appointments{
                    self.orders = appointments
                    self.updateOrderTableView()
                }
                else{
                    self.updateOrderTableView()
                }
            }
        }
    }
    
    func updateOrderTableView(){
        self.tblOrders.reloadData()
        self.tblReOrder.reloadData()
        
        let label = self.getNoDataLabel(tableORColView: self.tblOrders)
        
        self.orders.count == 0 ? (self.tblOrders.backgroundView = label)
        : (self.tblOrders.backgroundView = nil)
    }
    
}
