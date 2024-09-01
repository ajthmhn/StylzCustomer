//
//  AddshopRatingViewController.swift
//  Bilz
//
//  Created by Me on 1/28/24.
//

import UIKit
import StylesWebKit

//RatingsTableViewCell

class AddRatingViewController: BaseViewController {
    
    @IBOutlet var shopName_lbl: UILabel!
    @IBOutlet var restaurantImg_view: UIImageView!
    @IBOutlet var ratingMsg_lbl: UILabel!
    
    @IBOutlet var ratingBtns: [UIButton]!
    @IBOutlet var ratingImg: [UIImageView]!
    @IBOutlet var ratingView: [UIView]!
   
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var notNowBtn: UIButton!
  
    
    var rating = 1
    var shopName = ""
    var ratingMsg = ""
  
    var ratingDelegate : (() -> ())?
    var appointment:Appointments?

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUIWithRestaurantDetails()
        
    }
    
    
    
    
    @IBAction func onCLickBackBtn(_ sender: UIButton) {
        self.updateAppointmentStatusToNotRated()
    }
 
    @IBAction func onCLickContinueBtn(_ sender: UIButton) {
        if let delegate = self.ratingDelegate{
            delegate()}
   
    }
   
    @IBAction func onTapRatingBtn(_ sender: UIButton) {
        //print("on tap raitng tbn")
       // updateRating(index: sender.tag)
    }
    
    @IBAction func onTapNotNowBtn(_ sender: UIButton) {
        //print("on tap raitng tbn")
      updateAppointmentStatusToNotRated()
    }
    
}

//MARK: - handling ui
extension AddRatingViewController{
    
    
    func updateUIWithRestaurantDetails(){
      
        shopName = (LocalizationSystem.sharedInstance.getLanguage() == "ar" ? appointment?.salon_name_ar : appointment?.salon_name_en) ?? ""
        shopName_lbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.rate, comment: "")) \(shopName)"
    
        
        let msg1 = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.ratingMsg, comment: "")
        let msg2 = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.ratingMsg2, comment: "")
        
        ratingMsg_lbl.text = "\(msg1) \(shopName) \(msg2)"
        
        
        notNowBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.notNowBtn, comment: ""), for: .normal)
        
        continueBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.continueBtn, comment: ""), for: .normal)
        
        
        continueBtn.backgroundColor = getThemeColor()
        notNowBtn.tintColor = getThemeColor()
        
        setImage(imageView: restaurantImg_view, url: appointment?.salonLogo ?? "")
        
        
        
    
    }
}

//MARK: - update appointment status api
extension AddRatingViewController{
    
    func updateAppointmentStatusToNotRated(){
        
        let activityIndicator = self.getIndicator(controller: self)
        
        let appointmentID = appointment?.id ?? 0
       
        let request = UpdateAppointmentStatusRequest(appointmentID: appointmentID , appointmentStatus: 0)
        
        let resource = UpdateAppointmentStatusResource()
    
        resource.updateAppointmentStatus(request: request){ errorMsg in
            
            DispatchQueue.main.async {
                
              activityIndicator.removeFromSuperview()
                
              //print("error: \(errorMsg) ")
              self.dismiss(animated: true)
                    
            }
        }
    }
}


//
////MARK: - handling UI
//extension AddRatingViewController{
//  
//    func getRatingColor(index:Int) -> UIColor? {
//        switch index{
//        case 1,2:
//            return K.Color.star2
//        case 3:
//            return K.Color.star3
//        case 4,5:
//            return K.Color.star5
//        default:
//            return K.Color.star
//        }
//    }
//    
//    func updateRating(index:Int){
//        rating = index+1
//        for i in 0...ratingBtns.count-1 {
//            i<=index ?
//            (self.ratingImg[i].tintColor = getRatingColor(index: rating)) :
//            (self.ratingImg[i].tintColor = getRatingColor(index: -1))
//        }
//    
//        animationScaleEffectSingle(view: self.ratingView[index])
//    }
//}
