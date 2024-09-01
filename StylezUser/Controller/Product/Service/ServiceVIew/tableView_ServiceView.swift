//
//  tableView_ServiceView.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation
import UIKit

//MARK: - table view
extension ServiceViewController : UITableViewDataSource, UITableViewDelegate{
    
    func getTableViewCurrentTabCount()->Int{
        if isOffer == true{
            return offerList.count
        }else{
            if isEmplooyee == false{
//                if categories.count > 0{
//                    return categories[selectedService].services.count
//                }
                if services.count > 0{
                    return services.count
                }
            
                else{
                    return 0
                }
            }else{
                return employeeList.count
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == "contentSize"){
            if let newvalue = change?[.newKey]
            {
                let newsize  = newvalue as! CGSize
                if newsize.height == 0{
                    tblHeight.constant = 200
                }else{
                    tblHeight.constant = newsize.height + 80
                }
            }
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getTableViewCurrentTabCount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isOffer == true{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.offerCellId) as! ServiceListCell
            
            animationScaleEffectSingle(view: cell)
            
            cell.offerObj = offerList[indexPath.row]
            
            return cell
        }
        else{
            if isEmplooyee == false{
                let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.serviceCellId) as! ServiceListCell
                
                
             //   let service = categories[selectedService].services[indexPath.row]
                let service = services[indexPath.row]
                cell.service = service
                
                animationScaleEffectSingle(view: cell)
           
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.employeeCellId) as! ServiceListCell
                
                cell.employee = employeeList[indexPath.row]
                
                animationScaleEffectSingle(view: cell)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isOffer == true{
            return 125
        }else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if isOffer == true{
            copyCouponCodeAndShowAlert(index: indexPath.row)
        }else{
            if isEmplooyee == true{
                moveToEmployeeDetailView(index: indexPath.row)
            }else{
                moveToServiceDetailView(index: indexPath.row)
            }
        }
    }
}

//MARK: - handling tap on cell

extension ServiceViewController{
    
    func copyCouponCodeAndShowAlert(index:Int){
        UIPasteboard.general.string = offerList[index].discount_coupon
        showAlert(title: "", subTitle: LocalizationSystem.sharedInstance.localizedStringForKey(key: "code_copy", comment: ""), sender: self)
    }
    
    func moveToServiceDetailView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetail) as! ServiceDetailsViewController
        vc.modalPresentationStyle = .popover
       // let service = categories[selectedService].services
       
        let service = services[index]
        
        vc.selectedService = service
        vc.parents = self
        vc.isEmployee = false
        
        vc.branchID = salon?.id ?? 0
        //  vc.isWalkins = self.isWalkin
        self.present(vc, animated: true)
    }
    
    func moveToEmployeeDetailView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetail) as! ServiceDetailsViewController
        vc.modalPresentationStyle = .popover
        vc.selectedEmployee = employeeList[index]
        vc.parents = self
        vc.isEmployee = true
        vc.branchID = salon?.id ?? 0
        //   vc.isWalkins = self.isWalkin
        self.present(vc, animated: true)
    }
}
