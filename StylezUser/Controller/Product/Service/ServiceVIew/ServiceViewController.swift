//
//  ServiceViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 13/08/23.
//

import UIKit
import StylesWebKit
import ImageSlideshow


class ServiceViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "category_cell_id"
        static let serviceCellId = "service_cell_id"
        static let employeeCellId = "employee_cell_id"
        static let offerCellId = "offer_cell_id"
    }
    
    
    @IBOutlet var tblHeight: NSLayoutConstraint!
    @IBOutlet var tblServicew: UITableView!
    @IBOutlet var imgTabs: [UIImageView]!
    @IBOutlet var lblTabs: [UILabel]!
    @IBOutlet var viewCart: UIView!
    @IBOutlet var lblCart: UILabel!
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var colCategories: UICollectionView!
    @IBOutlet var bottomSpace: NSLayoutConstraint!
    @IBOutlet var viewCol: UIView!
    @IBOutlet var slider: ImageSlideshow!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var btnHeart: UIButton!
    @IBOutlet var imgLike: UIImageView!
    
    @IBOutlet var starImg: UIImageView!
    @IBOutlet var ratingLbel: UILabel!
    
    @IBOutlet var lblService: UILabel!
    @IBOutlet var lblOffer: UILabel!
    @IBOutlet var lblEmployee: UILabel!
    @IBOutlet var btnInsta: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var shareImg: UIImageView!
    
    
    var selectedService = 0
    var selectedCategoryID = 0
    var isOffer = false
    var isEmplooyee = false
    var salon : Salons?
    var categories = [Categories]()
    var services = [Services]()
    var employeeList = [Employee]()
    var offerList = [Services]()
    var favStatus = 0
    var firsttime = true
    var isFav = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
        
        setUpUI()
        
        //fetcing services, employees and offers data
        fetchData()
        
        //add slider
        addImageSlider()
        
        //settinh salon address
        lblAddress.text = salon?.invoice_address
        ratingLbel.text = "\(salon?.salon_rating ?? 0.0)"
        
        setInstaLink()
        
        localizeText()
        
        //setting the fav img
        //   setFavImage()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tblServicew.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        updateCartLabelView()
    }
    
    
    @IBAction func btnfavourite(_ sender: Any) {
        doMakeItFavOrUnFav()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier:  stryBrdId.cartId) as! CartViewController
        vc.isFromBack = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btmSelect(_ sender: UIButton) {
        firsttime = false
        setSelectedTabView(tag:sender.tag)
    }
    
    @IBAction func btnInsta(_ sender: Any) {
        guard let url = URL(string: salon?.insta_link ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    
    @IBAction func shareSalon(_ sender: Any) {
        shareLinkToOtherApps()
    }
    
}

//MARK: -
extension ServiceViewController{
    
    func fetchData(){
    
        self.fetchData(getOnlyServices: false)
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.checkIfFavourite()
        }
    }
    
    func setInstaLink(){
        if salon?.insta_link != nil &&  salon?.insta_link != ""{
            btnInsta.isHidden = false
            btnInsta.tintColor = getThemeColor()
        }
        else{
            btnInsta.isHidden = true
        }
    }
}


//MARK: - handling service bottom tabbar
extension ServiceViewController{
    
    func setSelectedTabView(tag: Int){
        for all in imgTabs{
            all.setImageColor(color: UIColor.darkGray)
        }
        for all in lblTabs{
            all.textColor = UIColor.darkGray
        }
        
        self.tblServicew.backgroundView = nil
        imgTabs[tag].setImageColor(color: getThemeColor())
        lblTabs[tag].textColor = getThemeColor()
        
        if tag == 2{
            self.isOffer = false
            self.isEmplooyee = true
            if employeeList.count == 0{
                getEmployees()
            }
            viewCol.isHidden = true
        }
        else if tag == 0{
            self.isOffer = false
            self.isEmplooyee = false
            if categories.count == 0{
                fetchData(getOnlyServices: false)
            }
            
            viewCol.isHidden = false
        }
        else{
            self.isOffer = true
            if offerList.count == 0{
                getOffers()
            }
            viewCol.isHidden = true
        }
        self.tblServicew.reloadData()
    }
}


//MARK: - handling cart
extension ServiceViewController{
    
    func updateCartLabelView(){
        if getCartData()?.count ?? 0 > 0{
            viewCart.isHidden = false
            bottomSpace.constant = 80
            lblCount.text = "\(getCartData()?.count ?? 0)"
            
            var totals = [Double]()
            
            if let cartData = getCartData(){
                for all in cartData{
                    totals.append(Double(all["price"] as? String ?? "0.0")!)
                }
            }
            
            let sum = totals.reduce(0, +)
            let vat = (15 * sum) / 100
            
            lblPrice.attributedText = getAttributesStringWithSum(sum: sum)
            
        }else{
            viewCart.isHidden = true
            bottomSpace.constant = 0
        }
    }
    
}


//MARK: - handling fav
extension ServiceViewController{
    
    func doMakeItFavOrUnFav(){
        if getUserDetails() == nil{
            showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "login_continue", comment: ""), sender: self)
            return
        }
        
        updateFavImgAndShowAlert()
        
        animationScaleEffectSingle(view: imgLike)
        
        makeThisSalonFavOrUnFav()
    }
    
    func updateFavImgAndShowAlert(){
        
        var alertMSg = ""
        
        if favStatus == 1{
            favStatus = 0
            imgLike.image = UIImage(named: "unlike")
            
            alertMSg =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "removed_mySalons", comment: "")
        }else{
            favStatus = 1
            imgLike.image = UIImage(named: "like")
            
            alertMSg =  LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_mySallons", comment: "")
        }
        
        showSuccess(title: "", subTitle: alertMSg, view: self.view)
    }
    
    
}
