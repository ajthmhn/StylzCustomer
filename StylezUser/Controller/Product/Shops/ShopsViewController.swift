//
//  ShopsViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 13/08/23.
//

import UIKit
import StylesWebKit

class ShopsViewController: BaseViewController {
    
    struct VCConst {
        static let barbersListCellId = "barber_list_cell_id"
    }
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblSalons: UITableView!
    @IBOutlet weak var lblHead: UILabel!
    
    var categoryId = 0
    var name = ""
    var salons = [Salons]()
    var isFromHome = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        setUpViewAndfetchData()
    }
    
    //  not using
    @IBAction func btnREquestLocation(_ sender: UISwitch) {
        if let bundleId = Bundle.main.bundleIdentifier,
           let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//MARK: -
extension ShopsViewController{
    
    func setUpViewAndfetchData(){
        if isFromHome == true{
            
            lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "all_barber", comment: "")
            
            updateTableSalonsView()
        }
        else{
            if latitude == 0.0{
                let label = self.getNoDataLabel(tableORColView: tblSalons)
                self.tblSalons.backgroundView = label
            }
            else{
                getShops()
                
                LocalizationSystem.sharedInstance.getLanguage() == "ar" ? (lblHead.text = "متجر لل \(name)")
                :    (lblHead.text = "Shop for \(name)")
                
            }
        }
    }
    
    
    func updateTableSalonsView(){
        self.tblSalons.reloadData()
        
        let label = getNoDataLabel(tableORColView: tblSalons)
        
        if self.salons.count == 0{
            self.tblSalons.backgroundView = label
        }else{
            self.tblSalons.backgroundView = nil
        }
    }
    
    
    func navigateToServiceView( index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.service) as! ServiceViewController
        vc.salon = salons[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

