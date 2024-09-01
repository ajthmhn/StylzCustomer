//
//  APIHHANDler_SCHEdule.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import Foundation
import UIKit
import StylesWebKit

//MARK: - unlock time
extension SelectDateViewController{
    
    // haven't updated
    
    // calling from the next page - summary view back btn's click
    func unlockTime(id: String){
        
        let loadingIndicator = UIActivityIndicatorView(frame: self.view.bounds)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating();
        
        self.view.addSubview(loadingIndicator)
        
        
        StylzAPIFacade.shared.unlockTime(id: id){ (aRes) in
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
            }
            
            if aRes?.statusCode == 200{
                if aRes?.json?["status"].boolValue == true{
                    self.getTimings()
                }else{
                    if let error = aRes?.json?["error"].array{
                        if error.count > 0{
                            showAlert(title: "", subTitle:  error[0].stringValue , sender: self)
                        }else{
                            showAlert(title: "", subTitle:  aRes?.json?["error"].stringValue ?? "" , sender: self)
                        }
                    }else{
                        if let error = aRes?.json?["error"].dictionary{
                            showAlert(title: "", subTitle:  error["employee_id"]?.stringValue ?? "" , sender: self)
                            
                        }
                        
                    }
                }
            }
        }
    }
    
}


//MARK: - get discount
extension SelectDateViewController{
    
    
    func moveToSummaryView(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.summary) as! SummeryViewController
        
        vc.date = self.lblDate.text ?? ""
        vc.time = self.timings[selectedTime].start_time ?? ""
        vc.dateView = self
        
        if isreOrder {
            vc.isReorde = true
            vc.appointments = self.appointmentDetails
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getDiscountAndMoveToSummaryView(){
        
        let activityIndicator = self.getIndicator(controller: self)
        
        let resource = GetDiscountResource()
        resource.getDiscount { discountValue, errorMsg in
            
            DispatchQueue.main.async {
                
                activityIndicator.removeFromSuperview()
                
                if let discountValue{
                    //print(" 3 fetched ddisocunt \(discountValue)")
                    K.User.dicountValue = discountValue
                }
                else{
                    //print(" 2 fetched ddisocunt \(discountValue)")
                    K.User.dicountValue = 15.0
                }
                
                self.moveToSummaryView()
            }
        }
    }
    
}

//MARK: - reschedulee
extension SelectDateViewController{
    
    func moveToThanKsViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.thanks) as! ThanksViewController
        vc.isRescedule = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    // updated - haven't checked
    func resceduleAppointment(){
        
        let loadingIndicator = self.getIndicator(controller:self)
        
        let appointmentId = appointmentDetails?.id ?? 0
        let starTime = timings[selectedTime].start_time ?? ""
        let endTime = timings[selectedTime].end_time ?? ""
        let salonId = appointmentDetails?.salon_id ?? 0
        let date = lblDate.text  ?? ""
        
        let request  =  RescheduleAppointmentRequest(appointmentID: appointmentId, date: date, startTime: starTime, endTime: endTime, salonId: salonId)
        
        //print(request)
        let resource = RescheduleAppointmentReesource()
        resource.resceduleAppointment(request: request) { errMsg in
            
            DispatchQueue.main.async {
                loadingIndicator.removeFromSuperview()
                
                if errMsg != nil, let errMsg{
                    showAlert(title: "", subTitle: errMsg, sender: self)
                }else{
                    self.moveToThanKsViewController()
                }
                
            }
        }
    }
}


//MARK: - get timings
extension SelectDateViewController{
    
    func updateTimingCollectionView(err:String?){
      
        self.colTimings.reloadData()
        
        let label = getNoDataLabel(tableORColView: colTimings, msg: err ?? "")
        label.numberOfLines = 2
        
        if self.timings.count == 0{
            self.colTimings.backgroundView = label
        }else{
            self.colTimings.backgroundView = nil
        }
        
    }
    
  
    func getTimings(){
        
        self.timings.removeAll()
        selectedTime = -1
        
        let loadingIndicator  = self.getIndicator(controller: self)
        
        //print("appoitment: aaddress: \(appointmentDetails?.salon_address), id:\(appointmentDetails?.id) , customer name \(appointmentDetails?.customerEmail)")
      
        let request = GetTimingsRequest(services: appointmentDetails?.services, isReschedule: isRescedule, isReorder: isreOrder, date: lblDate.text ?? "", branchId:appointmentDetails?.salon_id ?? 0)
        
        //print("~ getTimings \(request.getRequestBody())")
        
        let resource = GetTimingsResource()
        
        resource.checkAvailability(request: request) { timings, err in
            
            DispatchQueue.main.async {
               
                loadingIndicator.removeFromSuperview()
                
                
                if let timings{
                    self.timings = timings
                }
           
                self.updateTimingCollectionView(err: err)
            }
        }
    }
}
