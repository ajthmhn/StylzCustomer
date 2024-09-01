//
//  TableViewHandler_SummaryController.swift
//  StylezUser
//
//  Created by abcd on 30/05/2024.
//

import Foundation
import UIKit

extension SummeryViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10{
            return cards.count
        }else{
            if isReorde == true{
                return appointments?.services.count ?? 0
            }else{
                return getCartData()?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 10{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cardCellId) as! SalonListCell
            // cell.lblStar.textColor = getThemeColor()
            
            cell.lblName.text =  cards[indexPath.row].card_brand
            cell.lblService.text =  cards[indexPath.row].masked_pan
            
            if seletedCard == indexPath.row{
                cell.imgStar.isHidden = false
            }else{
                cell.imgStar.isHidden = true
            }
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! ServiceListCell
            // cell.lblStar.textColor = getThemeColor()
            
            if isReorde == true{
                let data = appointments?.services[indexPath.row]
                
                // cell.lblName.text = data?["customer_name"] as? String ?? ""
                cell.lblService.text = LocalizationSystem.sharedInstance.getLanguage() == "ar"  ? data?.service_name_ar : data?.service_name_en
                
                cell.lblName.text =  data?.employee_first_name
                cell.lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(data?.service_amount ?? "0.0")"
                if data?.employee_image != ""{
                    cell.imgProduct.backgroundColor = UIColor.clear
                    setImage(imageView: cell.imgProduct, url: data?.employee_image ?? "")
                }else{
                    cell.imgProduct.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                }
                
            }
            else{
              
                let data = getCartData()?[indexPath.row]
                
                // cell.lblName.text = data?["customer_name"] as? String ?? ""
                cell.lblService.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? data?["service_name_ar"] as? String ?? "" : data?["service_name_en"] as? String ?? ""
                cell.lblName.text =  data?["customer_name"] as? String
                
                cell.lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(data?["price"] as? String ?? "")"
                
                if data?["customer_image"] as? String == "" || data?["customer_image"] == nil{
                    cell.imgProduct.image = nil
                    cell.imgProduct.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
                }else{
                 //print("image \(data?["customer_image"])-")
                    cell.imgProduct.backgroundColor = UIColor.clear
                    setImage(imageView: cell.imgProduct, url: data?["customer_image"] as? String ?? "")
                }
                
            }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 10{
            return 90
        }else{
            return 100
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if tableView.tag == 10{
            seletedCard = indexPath.row
            tableView.reloadData()
            viewPayment.isHidden = false
            //initilizePayment()
        }
    }
}
