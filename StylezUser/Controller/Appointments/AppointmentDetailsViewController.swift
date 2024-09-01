//
//  AppointmentDetailsViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 15/08/23.
//

import UIKit
import StylesWebKit

class AppointmentDetailsViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "service_cell_id"
    }
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnRescedule: UIButton!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblDateHead: UILabel!
    @IBOutlet var lblTimeHead: UILabel!
    @IBOutlet var lblClientHead: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var lblCustomerName: UILabel!
    @IBOutlet var lblCustomerMobile: UILabel!
    @IBOutlet var lblCustomerEmail: UILabel!
    @IBOutlet var imgCustomer: UIImageView!
    @IBOutlet var btnCheckout: UIButton!
    @IBOutlet var bottomHeight: NSLayoutConstraint!
    @IBOutlet var serviceesTableView: UITableView!
    @IBOutlet var bottomViewForActiveAppoitments: UIView!
    
    
    @IBOutlet var mobileLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    
    var appointments : Appointments?
    
    var isReorde = false
   
    var appointmentId = 0
    var branchID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        fetchAppointmentData()
        
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.showCancelAppointmentAlert()
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnRescedule(_ sender: Any) {
        self.showAppointmentSchedulingAlert()
        
    }
    
    //MARK: - maps
    @IBAction func btnLocation(_ sender: Any) {
        if isReorde == true{
            let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.selectDate) as! SelectDateViewController
            vc.appointmentDetails = self.appointments
            vc.isreOrder = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            let latDouble = self.appointments?.salon_latitudeStirng
            let longDouble = self.appointments?.salon_longitudeString
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {  //if phone has an app
                
                if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(latDouble ??  "0.0"),\(longDouble ?? "0.0")&directionsmode=driving") {
                    UIApplication.shared.open(url, options: [:])
                }}
            else {
                //Open in browser
                if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(latDouble ?? "0.0"),\(longDouble ?? "0.0")&directionsmode=driving") {
                    UIApplication.shared.open(urlDestination)
                }
            }
        }
    }
}



//MARK: - handling ui
extension AppointmentDetailsViewController{
    
    
    func updateUI(){
        btnBack.tintColor = getThemeColor()
        //btnCancel.layer.borderColor = UIColor(hexString: "FF3386")?.cgColor //FF0000
        // btnCancel.layer.borderWidth = 1
        
        //    btnRescedule.layer.borderColor = UIColor.black.cgColor
        //  btnRescedule.layer.borderWidth = 1
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        mobileLbl.text = "\( LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.phone, comment: "")):"
        
        emailLbl.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.email, comment: "")):"
        
      
        btnCheckout.backgroundColor = getThemeColor()
    }
    
}


//MARK: - Table view

extension AppointmentDetailsViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments?.services.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
        animationScaleEffectSingle(view: cell)
        cell.selectionStyle = .none
        
        cell.lblName.text = appointments?.services[indexPath.row].employee_first_name
        cell.lblService.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? appointments?.services[indexPath.row].service_name_ar :  appointments?.services[indexPath.row].service_name_en
        
        cell.lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(appointments?.services[indexPath.row].service_amount ?? "")"
        
        cell.lblDuration.text = appointments?.services[indexPath.row].service_duration
        
        
        setImage(imageView: cell.imgProduct, url: appointments?.services[indexPath.row].employee_image ?? "", placeHolderImg: K.placeHolderImage.service)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - update data

extension AppointmentDetailsViewController{
    
    func doUpdateData(){
        
        lblDate.text = getFormatedDate2(dateString: appointments?.start_time ?? "", requiredformat: K.DateFormats._dateLocale)
        
        lblTime.text = getFormatedDate2(dateString: appointments?.start_time ?? "", requiredformat: K.DateFormats.timeLocale)
        
        lblCustomerName.text = appointments?.customerName
        lblCustomerMobile.text = appointments?.customerPhone
        lblCustomerEmail.text = appointments?.customerEmail
     
        setImage(imageView: imgCustomer, url: appointments?.customerImage ?? "",placeHolderImg: K.placeHolderImage.user)
        
        if isReorde == true{
            btnCancel.isHidden = true
            btnRescedule.isHidden = true
            btnCheckout.isHidden = false
            btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "re_order", comment: ""), for: .normal)
            bottomHeight.constant = 60
        }else{
            if appointments?.appointment_status == 1 || appointments?.appointment_status == 4 {
                bottomViewForActiveAppoitments.isHidden = false
                bottomHeight.constant = 180
                btnCancel.isHidden = false
                btnRescedule.isHidden = false
                btnCheckout.isHidden = false
                btnCheckout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "go_to_location", comment: ""), for: .normal)
            }else{
                bottomViewForActiveAppoitments.isHidden = true
                btnCheckout.isHidden = true
                btnCancel.isHidden = true
                btnRescedule.isHidden = true
                bottomHeight.constant = 0
            }
        }
        
        lblClientHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "client", comment: "")
        
        lblHead.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "appoint_details", comment: "")
        lblDateHead.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "date", comment: "")
        lblTimeHead.text =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "time", comment: "")
        btnCancel.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel", comment: ""), for: .normal)
        btnRescedule.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "rescedule", comment: ""), for: .normal)
        
    }
}


//MARK: - handling appointment details api
extension AppointmentDetailsViewController{
    
    func fetchAppointmentData(){
        //let loadingIndicator = getIndicator(controller: self)
        
        let request = GetAppointmentDetailsRequest(appointmentID: appointmentId)
        
        let resource = GetAppointmentDetailsResource()
        resource.getAAppointmentDDetailss(request: request) { appointments, err in
            
            DispatchQueue.main.async {
                
                //loadingIndicator.removeFromSuperview()
                if err != nil{
                    showAlert(title: "", subTitle: err!, sender: self)
                }
                else{
                    if let appointments, appointments.count>0{
                        //print("there's appointment data")
                        self.appointments = appointments[0]
                    }
                }
                
                self.doUpdateData()
                self.updateServicesTable()
            }
        }
    }
    
    func updateServicesTable(){
       
        self.serviceesTableView.reloadData()
        
        let label = getNoDataLabel(tableORColView: serviceesTableView)
        
        if self.appointments?.services.count == 0{
            self.serviceesTableView.backgroundView = label
        }else{
            self.serviceesTableView.backgroundView = nil
        }
    }
}



//MARK: - cancel appointment
extension AppointmentDetailsViewController{
    
    func showCancelAppointmentAlert(){
        let alertController = UIAlertController(title: "", message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "cancel_appopint", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.cancelAppointment()
        }
        let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func cancelAppointment(){
        let loadingIndicator = getIndicator(controller: self)
        
        
        StylzAPIFacade.shared.cancelAppointment(id: appointments?.id ?? 0) { (aRes) in
            DispatchQueue.main.async {
                if aRes?.statusCode == 200{
                    if aRes?.json?["status"].intValue == 200{
                        loadingIndicator.removeFromSuperview()
                        
                        let alertController = UIAlertController(title: "", message:  LocalizationSystem.sharedInstance.localizedStringForKey(key: "appointment_cancel", comment: ""), preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "ok", comment: ""), style: UIAlertAction.Style.default) {
                            UIAlertAction in
                            //print("ok tapped")
                            self.navigationController?.popViewController(animated: false)
                        }
                        
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                    else{
                        showAlert(title: "", subTitle: getErrMsg(json: aRes?.json), sender: self)
                    }
                }else{
                    showAlert(title: "", subTitle: getErrMsg(json: aRes?.json), sender: self)
                }
            }
        }
    }
}


//MARK: -  reschedule appointment
extension AppointmentDetailsViewController{
    
    func showAppointmentSchedulingAlert(){
        let alertController = UIAlertController(title: "", message: LocalizationSystem.sharedInstance.localizedStringForKey(key: "rescedule_appopint", comment: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "yes", comment: ""), style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            self.moveToSelectDateView()
        }
        let cancelAction = UIAlertAction(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: "no", comment: ""), style: UIAlertAction.Style.cancel) {
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func moveToSelectDateView(){
    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.selectDate) as! SelectDateViewController
        
        vc.isRescedule = true
        vc.appointmentDetails = self.appointments
        
        //print("appmnt: \(self.appointments?.appointment_status), \(self.appointmentId), \(self.appointments?.customerEmail)")
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
