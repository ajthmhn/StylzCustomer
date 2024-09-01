//
//  SalonListCell.swift
//  StylezUser
//
//  Created by Ajith Mohan on 10/08/23.
//

import UIKit
import StylesWebKit

class SalonListCell: UITableViewCell {
    
    @IBOutlet var lblStar : UILabel!
    @IBOutlet var imgStar : UIImageView!
    @IBOutlet var viewBg : UIView!
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblAddress : UILabel!
    @IBOutlet var lblStatus : UILabel!
    @IBOutlet var lblService : UILabel!
    @IBOutlet var viewStatus : [UIView]!
    @IBOutlet var tblHeight : NSLayoutConstraint!
    
    @IBOutlet var lblEmploName : UILabel!
    @IBOutlet var lblDate : UILabel!
    @IBOutlet var tblService: UITableView!
    @IBOutlet var lblPaid : UILabel!
    @IBOutlet var viewPaid : [UIView]!
    
    @IBOutlet var imgshop : UIImageView!
    
    //history
    @IBOutlet var lblServiceHead: UILabel!
    @IBOutlet var lblEmployeeHead : UILabel!
    
    @IBOutlet var rateYourOrderLabel : UILabel!
    
    @IBOutlet var rateYourORderBtnHeight : NSLayoutConstraint!
    @IBOutlet var ratingView : UIView!
   
 
    //history
    var services = [AppointmentService]()
    var employeeName = ""
    
    //HIstoryViewController
    var order_notReorderd : Appointments? {
        didSet{
            configOrders()
        }
    }
    
    //HIstoryViewController
    var order_Reorderd : Appointments? {
        didSet{
            configReorderedOrders()
        }
    }
    
    //ShopsViewController
    var branch : Salons? {
        didSet{
            configShopSalon()
        }
    }
    
    //SalonViewController
    var salon : Salons? {
        didSet{
            configSalon()
        }
    }
    
    
    
//    typealias ratingLAbelTapped = (SalonListCell) -> Void
//    var addRatingTappedAction : ratingLAbelTapped?
//    
//    //notifcationViewController
//    func addRatingTappedActions(handler:ratingLAbelTapped?) {
//        addRatingTappedAction = handler
//    }
//    
//    @IBAction func btnDelete(_ sender: UIButton) {
//        addRatingTappedActions(handler: self)
//    }

    
    typealias ratingTapped = (SalonListCell) -> Void
    var ratingTappedAction : ratingTapped?
    
    //notifcationViewController
    func ratingTappedActions(handler:ratingTapped?) {
        ratingTappedAction = handler
    }
    
    @IBAction func btnRating(_ sender: UIButton) {
        ratingTappedAction!(self)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

//MARK: - HIstoryViewController

//MARK: - employee list and services - HIstoryViewController
extension SalonListCell : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if services.count > 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                                                    "service_cell_id") as! SalonListCell
        
        //print("~ in history serivce cell id orders")
        
        cell.lblName.text = employeeName
        cell.lblService.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? services[indexPath.row].service_name_ar :  services[indexPath.row].service_name_en
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
