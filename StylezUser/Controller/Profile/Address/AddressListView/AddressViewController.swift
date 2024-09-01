//
//  AddressViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 20/08/23.

// updated file (With MVC)

import UIKit
import StylesWebKit

class AddressViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "address_cell_id"
    }
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var tblAddress: UITableView!
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var btnAddress: UIButton!
    
    var addressList = [Addresss]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setThemeColorAndLocalizeLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData2()
    }
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnAdd(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.addAddress) as! AddAddressViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - handlig address table view
extension AddressViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
        
        cell.viewBg.layer.cornerRadius = 20
        cell.viewBg.layer.masksToBounds = true
        cell.viewBg.dropShadow(color: UIColor.lightGray)
        
        cell.lblName.text  = addressList[indexPath.row].nick_name
        
        cell.imgStar.image = checkIfNotMale() == true ?  UIImage(named: "address_list_girl") : UIImage(named: "address_list")
        
        cell.deleteTappedActions { aCell in
            self.deleteAddress(index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

//MARK: - Handling UI
extension AddressViewController{
   
    func setThemeColorAndLocalizeLabels(){
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "address", comment: "")
        
        btnAddress.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_address", comment: ""), for: .normal)
      
        btnAddress.backgroundColor = getThemeColor()
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
    }
}

