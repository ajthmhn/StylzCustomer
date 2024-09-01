//
//  PlanHistoryTableViewCell.swift
//  StylezUser
//
//  Created by MACBOOK on 3/7/24.
//

import UIKit

class PlanHistoryTableViewCell: UITableViewCell {

    @IBOutlet var lblAmount: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblOrderID: UILabel!
    @IBOutlet var lblstylexPRemium: UILabel!
    @IBOutlet var lblSUbscription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func localizeText(){
     //   lblAmount.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.upgradeTopRemium, comment: "")
       // lblDate.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.upgradeTopRemium, comment: "")
        lblOrderID.text =  "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.orderID, comment: ""))145574541"
        lblstylexPRemium.text =   LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.stylPremium, comment: "")
        lblSUbscription.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.Subscription, comment: "")
        
    }
    
}
