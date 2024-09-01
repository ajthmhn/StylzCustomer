//
//  ServiceDetailsViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 13/08/23.
//

import UIKit
import StylesWebKit

class ServiceDetailsViewController: BaseViewController {

    struct VCConst {
        static let cellId = "barber_cell_id"
    }
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblEmployee: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblPriceHad: UILabel!
    @IBOutlet weak var lblDurationHead: UILabel!
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var lblDes: UILabel!
    @IBOutlet weak var desHeight: NSLayoutConstraint!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var detailsCollectionVieew: UICollectionView!

    
    var isEmployee = false
    
    var branchID = 0
    var selectedBarber = -1
    var selectedService : Services?
    var selectedEmployee : Employee?
    var employeeArraay = [Employee]()
    var parents : ServiceViewController?
    var searchView : SearchViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if selectedService != nil{
            getEmployees()
        }
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnAddCart(_ sender: Any) {
        handleCartAlertAndSaveCartData()
    }
}


