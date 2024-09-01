//
//  SearchViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 17/09/23.
//

import UIKit
import StylesWebKit



class SearchViewController: BaseViewController {
    
    struct VCConst {
        static let emplyeeCellId = "employee_cell_id"
        static let salonsCellId = "salon_list_cell_id"
        static let serviceCellId = "service_cell_id"
        static let stylistCellId = "barber_cell_id"
    }
    
    
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var tblSearch: UITableView!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var viewCart: UIView!
    @IBOutlet var lblCart: UILabel!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var bottomSpace: NSLayoutConstraint!
    @IBOutlet var bottomSpaceEmployee: NSLayoutConstraint!
    
    @IBOutlet var lblHead: UILabel!
    @IBOutlet var colStylists: UICollectionView!
    
    @IBOutlet var  searchView : UIView!
    @IBOutlet var searchViewHeight: NSLayoutConstraint!
 
    var employeeList = [Employee]()
    var mainEmployeeList = [Employee]()
   
    var serviceList = [Services]()
    var salons = [Salons]()
    var isStylist = false
    var keyWord = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTF()
    
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
      
        configView()
        
        localizeSearchbar()
        
        viewCart.isHidden = true
        txtSearch.text = keyWord
        
        configTb()
        
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
     //handle cart
        configCartView()
     }
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func oonClick_searchBtn(_ sender: Any) {
       
        isStylist == false ?
        getSearchedData() : filterData()
        
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.cartId) as! CartViewController
        vc.isFromBack = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - fetch data

extension SearchViewController{
   
    func fetchData(){
        if latitude ==  0.0{
            let label = getNoDataLabel(tableORColView: colStylists)
            self.colStylists.backgroundView = label
            return
        }
        else{
            isStylist ? getEmployees() : getSearchedData()
        }
    }
}


