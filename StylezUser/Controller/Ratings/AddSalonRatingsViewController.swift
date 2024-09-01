//
//  AddItemRatingsViewController.swift
//  Bilz
//
//  Created by Me on 1/28/24.
//

import UIKit
import StylesWebKit

class AddSalonRatingsViewController: BaseViewController{
    
    struct VCCont {
        static let cellId = "RatingsTableViewCell"
    }
    
    @IBOutlet weak var order_tableView_height: NSLayoutConstraint!
    @IBOutlet weak var View_height: NSLayoutConstraint!
    
    @IBOutlet var orderItem_tableView: UITableView!
    @IBOutlet var shopName_lbl: UILabel!
    @IBOutlet var shopRatingMsg_lbl: UILabel!
  
    @IBOutlet var note_textView: UITextView!
    @IBOutlet var restaurantImg_lbl: UIImageView!
    @IBOutlet var ratingImg: [UIImageView]!
    @IBOutlet var ratingBtns: [UIButton]!
    @IBOutlet weak var submitBtn: UIButton!
  
    @IBOutlet var ratingView: [UIView]!
    
    var ratingDelegate : ((String) -> ())?
    var rating = 1
    var appointment:Appointments?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateViewWithShopInfo()
        configTextView()
        updateRating(index: 0)
        
        //configRatingTableView()
    }
    
    @IBAction func onTapRatingBtn(_ sender: UIButton) {
        //print("on tap raitng tbn")
        updateRating(index: sender.tag)
    }
    
    @IBAction func onCLickBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onCLickContinueBtn(_ sender: UIButton) {
        addRatings()
    }
    
    
}

//MARK: - handling UI
extension AddSalonRatingsViewController{
    
    func updateViewWithShopInfo(){
        let shopName =   LocalizationSystem.sharedInstance.getLanguage() == "ar" ?
        appointment?.salon_name_ar ?? "": appointment?.salon_name_en ?? ""
       
        shopName_lbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.howWas, comment: "")) \(shopName)"
      
        
        shopRatingMsg_lbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.shopRatingMsg, comment: ""))"
     
        
        submitBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.submitBtn, comment: ""), for: .normal)
       
        submitBtn.backgroundColor = getThemeColor()
        
        let url = appointment?.salonLogo ?? ""
        setImage(imageView: restaurantImg_lbl, url: url)
        
    }
    
    
    func getRatingColor(index:Int) -> UIColor? {
        switch index{
        case 1,2:
            return K.Color.star2
        case 3:
            return K.Color.star3
        case 4,5:
            return K.Color.star5
        default:
            return K.Color.star
        }
    }
    
    func updateRating(index:Int){
        rating = index+1
        for i in 0...ratingBtns.count-1 {
            i<=index ?
            (self.ratingImg[i].tintColor = getRatingColor(index: rating)) :
            (self.ratingImg[i].tintColor = getRatingColor(index: -1))
        }
        //print("inddex \(index)")
        animationScaleEffectSingle(view: self.ratingView[index])
    }
}


//MARK: - config multiline textfield
extension AddSalonRatingsViewController: UITextViewDelegate{
    
    func configTextView(){
        let placeHolder = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.notesplaceholder, comment: "")
      
        note_textView.textColor = .lightGray
        
        note_textView.text = placeHolder
        
        note_textView.delegate = self
        note_textView.autocapitalizationType = .words
        
        
        LocalizationSystem.sharedInstance.getLanguage() == "ar" ?
        (note_textView.textAlignment = .right)
        :
        (note_textView.textAlignment = .left)
        
    }
    
    func textViewDidBeginEditing (_ textView: UITextView) {
      
        let placeHolder = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.notesplaceholder, comment: "")
        
        if note_textView.text == placeHolder{
            note_textView.textColor = .black
            note_textView.text = ""
        }
        
        else if note_textView.text != placeHolder || note_textView.text != "" {
            note_textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        let placeHolder = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.notesplaceholder, comment: "")
       
        if note_textView.text.isEmpty || note_textView.text == "" {
            note_textView.textColor = .lightGray
            note_textView.text = placeHolder
        }
    }
}


extension AddSalonRatingsViewController{
    
    func addRatings(){
        
        let activityIndicator = self.getIndicator(controller: self)
        var review = ""
        
        if let notes = note_textView.text, notes != K.MYStrings.notesplaceholder{
            review = notes
        }
        
        let customerId = getCustomerID() ?? 0
        let branchID  = appointment?.salon_id ?? 0
        let appointmentID = appointment?.id ?? 0
        
        let request = AddRatingRequest(rating: rating, review: review, brancID:branchID, customerID: customerId, appointmentID:appointmentID)
        
        //print("requeest: \(request.getRequestBody())")
        
        let resource = AddRatingResource()
        resource.addRatings(request: request) { errorMsg in
            
            DispatchQueue.main.async {
                
                activityIndicator.removeFromSuperview()
                
                if errorMsg != nil{
                    showAlert(title: "", subTitle: errorMsg!, sender: self)
                }
                else{
                    if let delegate =  self.ratingDelegate{
                        delegate("")
                    }
                }
               
            }
        }
    }
}
