//
//  tableViewHandler_History.swift
//  StylezUser
//
//  Created by mac on 11/03/2024.
//

import Foundation
import UIKit

//MARK: - table view
extension HIstoryViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblReOrder{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.reORdrcellId) as! SalonListCell
            //print("~ cell reordered")
            if isReORder{
                cell.order_Reorderd = orders[indexPath.item]
            }
            return cell
        }
        else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! SalonListCell
            
            //print("~ cell not reordered ")
            cell.order_notReorderd = orders[indexPath.row]
            
            cell.ratingTappedAction = { aCell in
                //print("rating cell taped ")
                self.moveToSalonRatingView(index: indexPath.row)
            }
            
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
        if tableView == tblReOrder{
            return 100
        }else{
            return UITableView.automaticDimension
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let stry = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.appointmentDetails) as! AppointmentDetailsViewController
        vc.appointments = self.orders[indexPath.row]
        vc.appointmentId = self.orders[indexPath.row].id ?? 0
        
        if tableView == tblReOrder{
            vc.isReorde = true
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

//MARK: raitgs
extension HIstoryViewController{
    
    
    func moveToSalonRatingView(index:Int){
        
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.AddSalonRatings) as! AddSalonRatingsViewController
        
        vc.appointment = self.orders[index]
        
        vc.ratingDelegate = { msg in
            
            //print("ratiing delete salon view")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                
                self.dismiss(animated: true)
             
                showSuccess(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.Thankyou, comment: ""), subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.feedbackSubmitted, comment: ""), view: self.view)

                self.getOrderHistory()
                
            }
            
        
        }
        
        self.present(vc, animated: true)
    }
    
}
