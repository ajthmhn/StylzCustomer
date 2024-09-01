//
//  RatingHomeViewController.swift
//  StylezUser
//
//  Created by abcd on 22/04/2024.
//

import Foundation
import StylesWebKit
import UIKit

//MARK: - handling rating navigation


extension HomeViewController{
    
    func getLastAppointmentdetailsForRating(){
        let resource = GetAppointmentDetailsForRatingResource()
        resource.getAppointmentRatingDetails { appointment, errorMsg in
            
            DispatchQueue.main.async {
                if appointment != nil, errorMsg == nil
                {
                    //print("last appointment details \(appointment?.id)")
                    self.showRatingView(appointment: appointment)
                }
            }
        }
    }
}

//MARK: rating navigation
extension HomeViewController{
    
    func showRatingView(appointment:Appointments?){
        
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.Rating) as! AddRatingViewController
        
        vc.isModalInPresentation = true
        vc.modalPresentationStyle = .popover
        vc.appointment = appointment
        vc.ratingDelegate = {
            //print("add rating delegate")
            self.dismiss(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                self.showEmmployeeRatingView(appointment: appointment)
            }
        }
        
        self.present(vc, animated: true)
        
    }
    
    
    func showShopRatingView(appointment:Appointments?){
        
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.AddSalonRatings) as! AddSalonRatingsViewController
        
        vc.modalPresentationStyle = .popover
        
        vc.appointment = appointment
        
        vc.ratingDelegate = { msg in
            self.dismiss(animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                    //   self.showShopRatingView()
                    
                    showSuccess(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.feedbackSubmitted, comment: ""), view: self.view)
                }
        }
        
        self.present(vc, animated: true)
    }
    
    
    
    func showEmmployeeRatingView(appointment:Appointments?){
        
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.AddEmployeeRatings) as! AddEmployeeRatingsViewController
        
        vc.modalPresentationStyle = .popover
        
        vc.appointment = appointment
        
        vc.isModalInPresentation = true
        vc.ratingDelegate = { msg in
            //print("add rating delegate")
            
            self.dismiss(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                self.showShopRatingView(appointment: appointment)
            }
        }
        
        self.present(vc, animated: true)
    }
    
    
}
