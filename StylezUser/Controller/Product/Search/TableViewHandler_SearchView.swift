//
//  TableViewHandler_SearchView.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit

extension SearchViewController : UITableViewDataSource, UITableViewDelegate{
    
    func configTb(){
        tblSearch.delegate = self
        tblSearch.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isStylist == true{
            return 1
        }else{
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return employeeList.count
        }else if section == 1{
            return salons.count
        }else {
            return serviceList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.emplyeeCellId) as! ServiceListCell
            animationScaleEffectSingle(view: cell)
            cell.dropShadow(color: UIColor.lightGray)
            
            cell.lblName.text =  employeeList[indexPath.row].first_name
            //cell.lblDuration.text = employeeList[indexPath.row].phone
            cell.lblDuration.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ?
            employeeList[indexPath.row].branchNameAr : employeeList[indexPath.row].branchNameEn
          
            setImage(imageView: cell.imgProduct, url: employeeList[indexPath.row].image ?? "")
            
            cell.lblPrice.text = employeeList[indexPath.row].employee_rating
            
            return cell
            
        }
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.salonsCellId) as! SalonListCell
            cell.lblStar.textColor = getThemeColor()
            cell.imgStar.tintColor = getThemeColor()
            
            cell.viewBg.layer.cornerRadius = 20
            cell.viewBg.layer.masksToBounds = true
            cell.viewBg.layer.borderColor = UIColor.lightGray.cgColor
            cell.viewBg.layer.borderWidth = 1
            
            cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? salons[indexPath.row].name_ar :  salons[indexPath.row].name_en
            
            cell.lblStar.text = "\(salons[indexPath.row].salon_rating ?? 0.0)"
            
            cell.lblAddress.text = salons[indexPath.row].invoice_address
          
            if salons[indexPath.row].salon_images.count > 0{
                setImage(imageView: cell.imgshop, url: salons[indexPath.row].salon_images[0], placeHolderImg: K.placeHolderImage.service)
            }else{
                cell.imgshop.image = UIImage(named: "test_2")
            }
            
            
            return  cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.serviceCellId) as! ServiceListCell
            animationScaleEffectSingle(view: cell)
            
            let service = serviceList
            
            cell.searchedService = service[indexPath.row]
            
            return cell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 120
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0{
            //move To ServiceDetails view
            moveToServiceDetails(index: indexPath.row)
            
        }else if indexPath.section == 1{
            //moveToServiceView
            moveToServiceView(index: indexPath.row)
        }
        else{
            //move to salon view old, new service ddetials view for services
            //moveToSalonView(index: indexPath.row)
            self.moveToServiceDetailView(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            if employeeList.count > 0{
                return 50
            }else{
                return 0
            }
            
        }else if section == 1{
            if salons.count > 0{
                return 50
            }else{
                return 0
            }
        }else{
            if serviceList.count > 0{
                return 50
            }else{
                return 0
            }
            
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 50))
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? .right : .left
        
        var  height:CGFloat = 50
       
//        "stylist" = "Stylists";
//        "services" = "Services";
//        "employee" = "Employees";
        
        
        if section == 0{
            if employeeList.count > 0{
//                label.text = "   Stylists"
                label.text = "   \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "stylist", comment: ""))"
            }else{
                label.text = ""
                height = 0
            }
            
        }else if section == 1{
            if salons.count > 0{
             //   label.text = "   Salons"
                label.text = "   \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Salons", comment: ""))"
             }else{
                label.text = ""
                height = 0
            }
        }else{
            if serviceList.count > 0{
               // label.text = "   Services"
                label.text = "   \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "services", comment: ""))"
             }else{
                label.text = ""
                height = 0
            }
        }
        
        let frame = tableView.frame
        
        if height == 0 {
            return nil
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: height))  // create custom view
        label.bounds = label.frame.insetBy(dx: 10.0, dy: 10.0);
   
        headerView.addSubview(label)
        
        return headerView
        
        //return label
        
    }
    
}

//MARK: - navigation
extension SearchViewController{
    
    func moveToSalonView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.salons) as! SalonsViewController
        vc.serviceId = self.serviceList[index].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func moveToServiceDetailView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetail) as! ServiceDetailsViewController
        vc.modalPresentationStyle = .popover
        // let service = categories[selectedService].services
        
        let service = self.serviceList[index]
        
        vc.selectedService = service
        vc.searchView = self
        
        vc.isEmployee = false
        
        vc.branchID = self.serviceList[index].branchId ?? 0
        //  vc.isWalkins = self.isWalkin
        self.present(vc, animated: true)
    }
    
    func moveToServiceView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.service) as! ServiceViewController
        vc.salon = salons[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func moveToServiceDetailsView(index:Int){
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetail) as! ServiceDetailsViewController
//        
//        vc.modalPresentationStyle = .popover
//        vc.selectedEmployee = employeeList[index]
//        
//        vc.searchView = self
//        vc.isEmployee = true
//        
//        //        if isStylist == false{
//        //            vc.isSearching = true
//        //        }
//        //
//        //   vc.isWalkins = self.isWalkin
//        
//        //print("search vview branchidd: \(employeeList[Index].branchId)")
//        vc.branchID = employeeList[Index].branchId
//        self.present(vc, animated: true)
//        
  //  }
}
