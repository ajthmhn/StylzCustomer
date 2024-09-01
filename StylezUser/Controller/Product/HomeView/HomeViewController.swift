//
//  OriginalHome.swift
//  StylezUser
//
//  Created by mac on 12/03/2024.
//

import UIKit
import MapKit
import StylesWebKit
import ImageSlideshow
import FirebaseMessaging

class HomeViewController: BaseViewController {
    
    struct VCConst {
        static let reOrderCellId = "reOrder_cell_id"
        static let recomsCellId = "recoms_cell_id"
        static let salonListCellId = "salon_list_cell_id"
        static let barbersListCellId = "barber_list_cell_id"
    }
    
    @IBOutlet var viewSearch : UIView!
    @IBOutlet var viewSlider : UIView!
    @IBOutlet var viewCategory : [UIView]!
    @IBOutlet var viewSalons : [UIView]!
    @IBOutlet var saonHeight : NSLayoutConstraint!
    @IBOutlet var barberHeight : NSLayoutConstraint!
    @IBOutlet var lbladdress : UILabel!
    @IBOutlet var view10Salons : UIView!
    @IBOutlet var tblTop : UITableView!
    @IBOutlet var viewBrabers : UIView!
    @IBOutlet var tblBarber : UITableView!
    @IBOutlet var viewOrder : UIView!
    @IBOutlet var colOrder : UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var lblSalons: UILabel!
    @IBOutlet weak var btnStylist: UIButton!
    @IBOutlet var btnslow: [UIButton]!
    @IBOutlet weak var lblappoint: UILabel!
    @IBOutlet weak var lblReOrder: UILabel!
    @IBOutlet weak var lblallBarber: UILabel!
    @IBOutlet weak var lblTopSalons: UILabel!
    @IBOutlet weak var viewLocation: UIView!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var viewMenus: UIView!
    @IBOutlet weak var slider: ImageSlideshow!
    
    @IBOutlet weak var lblScedules: UILabel!
    @IBOutlet weak var lblSaloons: UILabel!
    @IBOutlet weak var lblStylist: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var viewNoDataSaloon: UIView!
    @IBOutlet weak var viewNoDataBarber: UIView!
    @IBOutlet var lblNoData: [UILabel]!
    @IBOutlet var imgLocation: UIImageView!
    @IBOutlet var btnNOt: UIButton!
    
    
    let locationManager = CLLocationManager()
    
    var salons = [Salons]()
    var allBarbers = [Salons]()
    var orders = [Appointments]()
    var addressList = [Addresss]()
    var dataGot = false
    //  var deviceToken = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewOrder.isHidden = true
        
        //setting up view
        setupUI()
        
        
        configTF()

        imgLocation.tintColor = getThemeColor()
        
        //setting banner images
        setBannerImage()
        
        //localiztion
        localizeTab()
        localizeCategoryLabels()
        localalizeNoDataLabel()
        setLocationViewBtn()
        
        //notifcations
        setBtNOTImage()
        setNotificationObservers()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.txtSearch.resignFirstResponder()

        // fetch messagng token and update user details
        self.fetchMessagingTokenAndCallUpdateTokenAPI()
        
        //requesting location, and data(top 10 and salons) from server
        requateLocation()
        
        //  self.showRatingView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        self.txtSearch.resignFirstResponder()
        
        if getUserDetails() == nil{
            self.viewOrder.isHidden = true
        }else{
            //  getOrderHistory()
            DispatchQueue.global(qos: .userInitiated).async {
                self.getAddress()
                self.getLastAppointmentdetailsForRating()
            }
        }
        
        
    }
    
    
    override func viewDidLayoutSubviews() {
        if languageChange == true{
            UIView.appearance().semanticContentAttribute =   LocalizationSystem.sharedInstance.getLanguage() == "ar" ? .forceRightToLeft : .forceLeftToRight
        }
    }
    
    
    @IBAction func btnAddress(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.menu) as! MenuViewController
        vc.address = self.addressList
        vc.homeView = self
        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
        
        navController.navigationBar.isHidden = true
        navController.modalPresentationStyle = .overFullScreen
        self.present(navController, animated: false)
    }
    
    @IBAction func btnREquestLocation(_ sender: UISwitch) {
      goToLocationSettings()
    }
    
    @IBAction func btnCategory(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.category) as! CategoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTopSalons(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.salons) as! SalonsViewController
        vc.salons = self.salons
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnhops(_ sender: UIButton) {
        if sender.tag == 0{
            let stry = UIStoryboard(name: "Profile", bundle: nil)
            let vc = stry.instantiateViewController(withIdentifier: stryBrdId.history) as! HIstoryViewController
            vc.isReORder = true
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.shops) as! ShopsViewController
            vc.isFromHome = true
            vc.salons = self.allBarbers
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func btnMain(_ sender: UIButton) {
        if sender.tag == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.salons) as! SalonsViewController
            vc.isMySalons = true
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.appointments) as! AppointmentsViewController
            vc.isFromHome = true
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    @IBAction func bnSearch(_ sender: UIButton) {
        if sender.tag == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.search) as! SearchViewController
            self.navigationController?.pushViewController(vc, animated: false)
        } else
        if sender.tag == 2{
            
           // if txtSearch.hasText, txtSearch.text != "",((txtSearch.text?.isEmptyOrWhitespace()) == false){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.search) as! SearchViewController
                vc.keyWord = txtSearch.text ?? ""
                txtSearch.resignFirstResponder()
                txtSearch.text = ""
                self.navigationController?.pushViewController(vc, animated: false)
          //  }
        }
        else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.search) as! SearchViewController
            vc.isStylist = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
 
    @IBAction func btnNOts(_ sender: UIButton) {
        let stry = UIStoryboard(name: "Profile", bundle: nil)
        let vc = stry.instantiateViewController(withIdentifier:  stryBrdId.notifications) as! NotificationsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


