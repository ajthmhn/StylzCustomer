//
//  SelectDateViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 14/08/23.
//

import UIKit
import FSCalendar
import StylesWebKit

class SelectDateViewController: BaseViewController {
    
    struct VCCont {
        static let cellId = "time_cell_id"
    }
    
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet var calender: FSCalendar!
    @IBOutlet var calenderView: UIView!
    @IBOutlet var lblDate: UITextField!
    @IBOutlet var colTimings: UICollectionView!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblAvbailable: UILabel!
   
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    var selectedTime = -1
    var isRescedule = false
    var timings = [Timings]()
    var appointmentDetails : Appointments?
    var isreOrder = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCheckout.backgroundColor = getThemeColor()
        
        btnBack.tintColor = getThemeColor()
       
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        setDateLabel()
        
        localizeView()
        
        getTimings()
        
        lblDate.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        
        if LocalizationSystem.sharedInstance.getLanguage()  == "ar"{
            lblDate.textAlignment = .right
        }else{
            lblDate.textAlignment = .left
        }
    }
    
    @IBAction func btnCalenderShow(_ sender: Any) {
       showCalender()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
  }
    
    @IBAction func btnBack(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.popViewController(animated: false)
 }
    
    @IBAction func btnCalenderActions(_ sender: UIButton) {
        if sender.tag == 1{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            dateFormat.locale  = Locale(identifier: "en")
            lblDate.text = dateFormat.string(from: self.calender.selectedDate ?? Date())
            
            getTimings()
        }
        self.calenderView.removeFromSuperview()
    }
    
   
    @IBAction func btnContinue(_ sender: Any) {
        
        let timeErr = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.Error.timingError, comment: "")
    
        if timings.count == 0{
            showAlert(title: "", subTitle: timeErr, sender: self)
            return
        }
        
        if selectedTime == -1{
            showAlert(title: "", subTitle: timeErr, sender: self)
            return
        }
        
        if isRescedule == true{
            self.resceduleAppointment()
        }else{
            // moveToSummaryView()
        getDiscountAndMoveToSummaryView()
        }
    }
}


//MARK: - handling calender
extension SelectDateViewController:FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance{
    
    func showCalender(){
        Bundle.main.loadNibNamed("CalenderView", owner: self)
       
        btnDone.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "done", comment: ""), for: .normal)
        
        btnCancel.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: ""), for: .normal)
        
        
        self.calenderView.frame = self.view.bounds
        self.view.addSubview(self.calenderView)
        self.view.bringSubviewToFront(self.calenderView)
        self.calender.select(Date())
        animationScaleEffectSingle(view: self.calender)
        
        self.calender.delegate = self
        calender.semanticContentAttribute = .forceLeftToRight
        calender.calendarWeekdayView.semanticContentAttribute = .forceLeftToRight
        calender.calendarHeaderView.semanticContentAttribute = .forceLeftToRight
        
        
        if LocalizationSystem.sharedInstance.getLanguage() == "ar" {
            if languageChange == true{
                
            }
            let loc = Locale(identifier: "en")
            self.calender.locale = loc
        }else{
            let loc = Locale(identifier: "en")
            self.calender.locale = loc
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
    }
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        let threeDays = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let day = Calendar.current.date(byAdding: .day, value: 1, to: date)
        
        if day! < threeDays!{
            return false
        }else{
            return true
            
        }
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let threeDays = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let day = Calendar.current.date(byAdding: .day, value: 1, to: date)
        
        
        if day! < threeDays!{
            return UIColor.gray
        }else{
            return UIColor.black
        }
    }
}

//MARK: - date picker
extension SelectDateViewController{
    
    @objc func doneButtonPressed() {
        if let  datePicker = self.lblDate.inputView as? UIDatePicker {
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd"
            dateFormat.locale  = Locale(identifier: "en")
            lblDate.text = dateFormat.string(from: datePicker.date)
            
            getTimings()
        }
        self.lblDate.resignFirstResponder()
    }
}

extension UITextField {
    
    func addInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        let loc = Locale(identifier: "en_US")
        datePicker.locale = loc
        
        
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        self.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: ""), style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "done", comment: ""), style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
}
