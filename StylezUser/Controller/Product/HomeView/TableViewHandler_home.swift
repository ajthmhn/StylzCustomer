//
//  homeTableViewHandler.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation
import UIKit
import StylesWebKit


//MARK: - table view
extension HomeViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return salons.count
        }else{
            return allBarbers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.salonListCellId) as! SalonListCell
            cell.lblStar.textColor = getThemeColor()
            cell.imgStar.tintColor = getThemeColor()
            
            cell.viewBg.layer.cornerRadius = 20
            cell.viewBg.layer.masksToBounds = true
            cell.viewBg.layer.borderColor = UIColor.lightGray.cgColor
            cell.viewBg.layer.borderWidth = 1
            if salons.count > 0 {
                
                cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? salons[indexPath.row].name_ar :  salons[indexPath.row].name_en
                
                cell.lblStar.text = "\(salons[indexPath.row].salon_rating ?? 0.0)"
                
                cell.lblAddress.text = salons[indexPath.row].invoice_address
                if salons[indexPath.row].salon_images.count > 0{
                    setImage(imageView: cell.imgshop, url: salons[indexPath.row].salon_images[0],placeHolderImg: K.placeHolderImage.service )
                }else{
                    cell.imgshop.image = UIImage(named: "test_2")
                }
            }
            return  cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.barbersListCellId) as! SalonListCell
            cell.lblStar.textColor = getThemeColor()
            cell.imgStar.tintColor = getThemeColor()
            
            cell.viewBg.layer.cornerRadius = 20
            cell.viewBg.dropShadow(color: UIColor.lightGray)
            //cell.viewBg.layer.masksToBounds = true
            
            if allBarbers.count > 0{
                cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? allBarbers[indexPath.row].name_ar :  allBarbers[indexPath.row].name_en
                cell.lblStar.text = "\(allBarbers[indexPath.row].salon_rating ?? 0.0)"
                cell.lblAddress.text = allBarbers[indexPath.row].invoice_address
                if allBarbers[indexPath.row].salon_images.count > 0{
                    setImage(imageView: cell.imgshop, url: allBarbers[indexPath.row].salon_images[0],placeHolderImg: K.placeHolderImage.service )
                }else{
                    cell.imgshop.image = UIImage(named: "test_2")
                }
            }
            return  cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 0{
            return 100
        }else{
            return 270
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if tableView.tag == 0{
     
            let salon = salons[indexPath.row]
           // checkIfFavourite(salon: salon)
            self.moveToServices( salon: salon)
       
        }else{
            
            let salon = allBarbers[indexPath.row]
            //checkIfFavourite( salon: salon)
            self.moveToServices( salon: salon)
        }
    }
}


//MARK: - navigate To services screen
extension HomeViewController{
    
    func moveToServices(id:Int = 0, salon:Salons, favStatus:Int = 0){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.service) as! ServiceViewController
        vc.salon = salon
        //vc.favStatus = favStatus
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
