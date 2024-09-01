//
//  AddAddressViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 14/09/23.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MapKit
import GoogleMaps
import GooglePlaces
import DropDown
import StylesWebKit

class AddAddressViewController: BaseViewController {
    
    
    @IBOutlet weak var txtNickName: MDCOutlinedTextField!
    @IBOutlet weak var isDefault: UISwitch!
    @IBOutlet weak var lblHead: UILabel!
    @IBOutlet weak var lblIsDefault: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var imgBack: UIButton!
    
    @IBOutlet var viewyTypes: [UIView]!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnBAck: UIButton!
    @IBOutlet weak var viewNickName: UIView!
    
    var tableView: UITableView!
    var tableDataSource: GMSAutocompleteTableDataSource!
    
    var isFirst = false
    var index = -1
    var canCall = false
    var isFristTime = true
    let marker = GMSMarker()
    var selectedLocation : CLLocation?
    var countryLatitude : Double?
    var countryLongitude : Double?
    var crntaddress = ""
    var adressChoosed = false
    let locationManager = CLLocationManager()
    var valueNOtTaken = false
    var addressSelecteds = false
    var homeView : HomeViewController?
    var searchBar = UISearchBar()
    var selectedAddres : Addresss?
    var isAddingFromHome = false
    var shouldAutoFill = true
    
    var tempAddress = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set textField Alignment
        setTxtFieldALignment(tf: txtNickName)
        
        //Set theme background color
        setThemeColor()
        
        // add and config search bar
        addSearchBar()
        // add places table view
        addPlacesTableView()
       
        configSearchBar()
        
        //config location manager
        configLocationManager()
        
        //
        setDesign()
    }
    
    
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        if homeView != nil{
            saveConstantsAndMoveToHome()
        }
        else{
            addAddress2()
        }
    }
    
    func saveConstantsAndMoveToHome(){
       
        //print("saving constants and moving to home ")
     
        //if self.homeView != nil{
        //   userAddress = "456 \(address.country ?? ""), \(address.locality ?? "")"
       //}
 
        userAddress = tempAddress
        
        addressSelected = true
        latitude = self.countryLatitude ?? 0.0
        longitude = self.countryLongitude ?? 0.0
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}


//MARK: - handling mapview
extension AddAddressViewController{
    
    func configMapView(){
        self.mapView.delegate = self
        self.mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 0)
    }
}

extension AddAddressViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the GMSAutocompleteTableDataSource with the search text.
        tableDataSource.sourceTextHasChanged(searchText)
        tableView.isHidden = false
    }
}

