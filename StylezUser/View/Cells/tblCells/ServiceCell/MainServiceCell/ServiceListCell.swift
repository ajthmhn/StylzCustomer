//
//  ServiceList.swift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit
import StylesWebKit

class ServiceListCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgProduct: UIImageView!
    @IBOutlet var lblDuration: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblService: UILabel!
    @IBOutlet var viewBg: UIView!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var imgStar: UIImageView!
    @IBOutlet var viewNot: UIView!
    @IBOutlet var lblPaid : UILabel!
    @IBOutlet var viewPaid : [UIView]!
    
    @IBOutlet var lblRateHead: UILabel!
    @IBOutlet var lblDurationHead: UILabel!
   
    @IBOutlet var branchName: UILabel!
   
    
    
    @IBOutlet var rateYourOrderLabel : UILabel!
    
    @IBOutlet var rateYourORderBtnHeight : NSLayoutConstraint!
    @IBOutlet var ratingView : UIView!
   
    //NotficationViewController
    var index = -1
    var notification:NOtifications? {
        didSet{
            configNotification()
        }
    }
    
    // ServiceViewController
    var offerObj: Services?{
        didSet{
            configOfferCell()
        }
    }
    
    // ServiceViewController
    var service: Services? {
        didSet{
            configServiceCell()
        }
    }
    
    //ServiceViewController
    var employee: Employee? {
        didSet{
            configEmployeeCell()
        }
    }
    
    //searchViewController
    var searchedService:Services?{
        didSet{
            configSearchedServiceCell()
        }
    }
    
    typealias deleteTapped = (ServiceListCell) -> Void
    var deleteTappedAction : deleteTapped?
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
 
    //notifcationViewController
    func deleteTappedActions(handler:deleteTapped?) {
        deleteTappedAction = handler
    }
    
    @IBAction func btnDelete(_ sender: UISwitch) {
        deleteTappedAction!(self)
    }
    
}
