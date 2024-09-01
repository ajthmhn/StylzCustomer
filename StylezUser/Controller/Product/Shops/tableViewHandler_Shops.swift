//
//  tableViewHandler_Shops.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit


//MARK: _ table view

extension ShopsViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.barbersListCellId) as! SalonListCell
        
        cell.branch = salons[indexPath.row]
       
        return  cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        navigateToServiceView(index: indexPath.row)
        
    }
    
}


