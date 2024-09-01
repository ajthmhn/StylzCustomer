//
//  AddItemRatingsViewController.swift
//  Bilz
//
//  Created by Me on 1/28/24.
//

import UIKit
import StylesWebKit

class AddEmployeeRatingsViewController: BaseViewController{
    
    struct VCCont {
        static let cellId = "RatingsTableViewCell"
    }
    
    @IBOutlet weak var eemployee_tableView_height: NSLayoutConstraint!
    @IBOutlet weak var View_height: NSLayoutConstraint!
    
    @IBOutlet var shopName_lbl: UILabel!
    @IBOutlet var ratingMsg_lbl: UILabel!
    @IBOutlet var restaurantImg_View: UIImageView!
    @IBOutlet var ratingImg: [UIImageView]!
    @IBOutlet var empRatingMsg_lbl: UILabel!
  
    
    @IBOutlet var employee_tableView: UITableView!
    @IBOutlet var note_textView: UITextView!
    @IBOutlet weak var continueBtn: UIButton!
  
    
    let viewHeightConstant:CGFloat = 360
    
    var ratingDelegate : ((String) -> ())?
    var employeeList:[Employee]?
    var shopRating = 0
    var orderID = 0
    var shopName = ""
    var itemRaitngs = [Int]()
    var appointment:Appointments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configTextView()
        updateRatingView()
        updateUIWithShopDetails()
        configRatingTableView()
    }
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        updateEntireView()
    //       }
    //
    
    @IBAction func onCLickBackBtn(_ sender: UIButton) {
        //    self.dismiss(animated: true)
        updateAppointmentStatusToNotRated()
    }
    
    @IBAction func onCLickContinueBtn(_ sender: UIButton) {
        doAddRating()
    }
    
}



//MARK: -- employee table view
extension AddEmployeeRatingsViewController : UITableViewDelegate,UITableViewDataSource, RatingsDelegate{
    // Then you can change the height for the table dynamicaly using this code:
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                DispatchQueue.main.async {
                    let newsize  = newvalue as! CGSize
                    //print("window size \(self.windowHeight())")
                    
                    let maxHeight: CGFloat = UIScreen.main.bounds.size.height
                    
                    self.eemployee_tableView_height.constant = min(newsize.height, maxHeight - self.viewHeightConstant)
                    
                    // //print("table view height \(newsize), min: \(self.windowHeight() - self.viewHeightConstant), min: \(maxHeight - self.viewHeightConstant), ")
                    
                    // //print("view height \( self.eemployee_tableView_height.constant + self.viewHeightConstant)")
                    
                    //  let newHeight = self.eemployee_tableView_height.constant + self.viewHeightConstant
                    
                    //   self.View_height.constant = min(newHeight, maxHeight) - 20 //280 actual
                    
                }
            }
        }
    }
    
    func rateOrder(tag: Int, currentIndex: Int) {
        if  employeeList != nil, self.employeeList?.count ?? 0>currentIndex{
            self.employeeList?[currentIndex].empRating = tag + 1
        }
        let indexPosition = IndexPath(row: currentIndex, section: 0)
        employee_tableView.reloadRows(at: [indexPosition], with: .none)
    }
    
    func configRatingTableView(){
        employeeList = appointment?.employee
        
        employee_tableView.delegate = self
        employee_tableView.dataSource = self
        
        employee_tableView.register(UINib(nibName: VCCont.cellId, bundle: nil), forCellReuseIdentifier: VCCont.cellId)
        
        self.employee_tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        self.employee_tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let employeeList{
            return employeeList.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCCont.cellId, for: indexPath)
        as! RatingsTableViewCell
        
        if let employeeList,employeeList.count>indexPath.row{
            cell.empolyeeData = employeeList[indexPath.row]
            
            cell.delegate = self
            cell.currentIndex = indexPath.row
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


//MARK: - config multiline textfield
extension AddEmployeeRatingsViewController: UITextViewDelegate{
    
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

//MARK: - handling ui
extension AddEmployeeRatingsViewController{
    
    
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
    
    func updateRatingView(){
       
        let rating = (appointment?.salonRating ?? 0.0).rounded(toPlaces: 0)  // Swift 3 version
        
        //print("rating \(rating) , \(Int(rating))")
        
        shopRating = Int(rating)
        
        for i in 0...ratingImg.count-1 {
            i<=shopRating-1 ?
            (self.ratingImg[i].tintColor = getRatingColor(index: shopRating)) :
            (self.ratingImg[i].tintColor = getRatingColor(index: -1))
        }
    }
    
    //    func updateEntireView(height:Int){
    //        self.employee_tableView.invalidateIntrinsicContentSize()
    //        employee_tableView.sizeToFit()
    //        employee_tableView.reloadData()
    //
    //
    //        let maxHeight: CGFloat = UIScreen.main.bounds.size.height
    //
    //       // self.eemployee_tableView_height.constant = min(newsize.height, maxHeight - self.viewHeightConstant)
    //
    //        let height = employee_tableView.contentSize.height
    //        eemployee_tableView_height.constant = min(height, maxHeight - viewHeightConstant)
    //
    //        //print("table view height \(height), min: \(windowHeight() - viewHeightConstant)")
    //
    //
    //
    //        View_height.constant = eemployee_tableView_height.constant + viewHeightConstant //280 actual height
    //
    //        let newHeight = self.eemployee_tableView_height.constant + self.viewHeightConstant
    //
    //        self.View_height.constant = min(newHeight, maxHeight) - 20 //280 actual
    //
    //        self.view.layoutIfNeeded()
    //    }
    
    func updateUIWithShopDetails(){
        
        shopName = (LocalizationSystem.sharedInstance.getLanguage() == "ar" ? appointment?.salon_name_ar : appointment?.salon_name_en) ?? ""
        
        
        let staff = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.staff, comment: "")
        let howWas = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.howWas, comment: "")
        shopName_lbl.text = "\(howWas) \(shopName) \(staff)"
        
        
        let msg1 = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.rateEach, comment: "")
        let msg2 = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.staffsBehaivior, comment: "")
        ratingMsg_lbl.text = "\(msg1) \(shopName) \(msg2)"
        
        
        empRatingMsg_lbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.staffRatingMSg, comment: ""))"
     
        
        continueBtn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.continueBtn, comment: ""), for: .normal)
      
        continueBtn.backgroundColor = getThemeColor()
        
        setImage(imageView: restaurantImg_View, url: appointment?.salonLogo ?? "")
       
        
    }
}


//MARK: employee rating api
extension AddEmployeeRatingsViewController{
    
    func getRatingOb() -> [Rating]{
        var ratings=[Rating]()
        
        if let employeeList
        {
            for emp in employeeList{
                ratings.append(Rating(employeeID: emp.id ?? 0, employeeRating:emp.empRating))
            }
        }
        //print("raitng object \(ratings)")
        return ratings
    }
    
    
    
    func doAddRating(){
        
        let activityIndicator = self.getIndicator(controller: self)
        
        var review = ""
        
        if let notes = note_textView.text, notes != K.MYStrings.notesplaceholder{
            review = notes
        }
        
        //  let customerId = getCustomerID() ?? 0
        //  let branchID  = appointment?.salon_id ?? 0
        
        let appointmentID = appointment?.id ?? 0
        
        // apointment status 2 is for completed appoitment
        let request = EmployeeRatingRequest(appointmentID: appointmentID, review: review, appointmentStatus: 2, ratings: getRatingOb())
        
        //print("requeest: \(request.getRequestBody())")
        
        let resource = CreateEmployeeRatingResource()
        resource.createEmployeeRating(request: request){ errorMsg in
            
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


//MARK: - update appointment status api
extension AddEmployeeRatingsViewController{
    
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



