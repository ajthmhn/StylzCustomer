//
//  HIstoryViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 20/08/23.
//

import UIKit
import StylesWebKit

class HIstoryViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "history_cell_id"
        static let reORdrcellId = "reOrder_cell_id"
    }
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblOrders: UITableView!
    @IBOutlet var tblReOrder: UITableView!
    @IBOutlet var lblHead: UILabel!
    
    
    var orders = [Appointments]()
    var isReORder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("~ history controller with is reorder:\(isReORder)")
        
        self.tblOrders.delegate = self
        self.tblOrders.dataSource = self
        
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "history", comment: "")
        
        updateViewForOrderedOrReorderedData()
        
        getOrderHistory()
   }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - UI
extension HIstoryViewController{
    
    func updateViewForOrderedOrReorderedData(){
        if isReORder == true{
            tblOrders.isHidden = true
            tblReOrder.isHidden = false
        }else{
            tblOrders.isHidden = false
            tblReOrder.isHidden = true }
    }
}

extension UIColor {
    
    var lighterColor: UIColor {
        return lighterColor(removeSaturation: 0.5, resultAlpha: -1)
    }
    
    func lighterColor(removeSaturation val: CGFloat, resultAlpha alpha: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        else {return self}
        
        return UIColor(hue: h,
                       saturation: max(s - val, 0.0),
                       brightness: b,
                       alpha: alpha == -1 ? a : alpha)
    }
}

