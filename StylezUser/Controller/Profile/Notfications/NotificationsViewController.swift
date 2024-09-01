//
//  NotificationsViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 20/08/23.
//

import UIKit
import StylesWebKit

class NotificationsViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "notifications_cell_id"
    }
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblNotif: UITableView!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var viewDetail: UIView!
  
    
    var notifications = [NOtifications]()
    var page = 1
    var isDataLoading = true
    var dataEmpty = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData2()
        
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "notifications", comment: "")
    }
        
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickHidedetailsBtn(_ sender: UIButton) {

        viewDetail.isHidden = true
    }
}



//MARK: table view
extension NotificationsViewController : UITableViewDataSource, UITableViewDelegate{
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let contentOffsetX = scrollView.contentOffset.y
//        if contentOffsetX >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
//            if !isDataLoading {
//                isDataLoading = true
//                page += 1
//                if self.dataEmpty == false{
//                    self.getData2()
//                }
//            }
//        }
//    }
//    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
        
        if page == 1{
            animationScaleEffectSingle(view: cell)
        }
        
        cell.index = indexPath.row
       
        if indexPath.row<notifications.count{
            cell.notification = notifications[indexPath.row]
        }
       
        cell.deleteTappedActions { aCell in
            self.moveToSaloRatingView(index: indexPath.row)
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row<notifications.count{
            let notification = notifications[indexPath.row]
            lblDetails.text =  "\n\(notification.title ?? "")\n\n\(notification.message ?? "")\n"
        }
        
        viewDetail.isHidden = false
        
       animationScaleEffectSingle(view: viewDetail)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


//MARK: ratings
extension NotificationsViewController{
    

    
    func moveToSaloRatingView(index:Int){
        
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier: stryBrdId.AddSalonRatings) as! AddSalonRatingsViewController
        
        vc.appointment = self.notifications[index].appointment
        
        vc.ratingDelegate = { msg in
            
            //print("ratiing delete salon view")
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5){
                
                self.dismiss(animated: true)
             
                showSuccess(title: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.Thankyou, comment: ""), subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: K.MYStrings.feedbackSubmitted, comment: ""), view: self.view)

                self.getData2()
                
            }
        }
        self.present(vc, animated: true)
    }
    
}
