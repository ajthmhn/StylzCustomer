//
//  HomeCollectionViewHandle.swift
//  StylezUser
//
//  Created by MACBOOK on 2/28/24.
//

import Foundation
import UIKit
extension HomeViewController : UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.reOrderCellId, for: indexPath) as! ReOrderColCell
            
            cell.viewBg.layer.cornerRadius = 20
            cell.viewBg.layer.masksToBounds = true
            cell.viewBg.layer.borderColor = UIColor.lightGray.cgColor
            cell.viewBg.layer.borderWidth = 0.5
            cell.viewBg.dropShadow(color: UIColor.lightGray)
            
            if orders.count > 0{
                let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 9.0)!, NSAttributedString.Key.foregroundColor : getThemeColor()]
                let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 14.0)!, NSAttributedString.Key.foregroundColor : getThemeColor()]
                let attributedString1 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: ""))", attributes:attrs1 as [NSAttributedString.Key : Any])
                let attributedString2 = NSMutableAttributedString(string:" \(orders[indexPath.item].service_amount ?? 0.0)", attributes:attrs2 as [NSAttributedString.Key : Any])
                attributedString1.append(attributedString2)
                
                cell.lblPrice.attributedText = attributedString1
                
                var name = [String]()
                for all in orders[indexPath.item].services{
                    name.append(LocalizationSystem.sharedInstance.getLanguage() == "ar" ? all.service_name_ar ?? "" : all.service_name_en ?? "")
                }
                
                
                cell.lblService.text = name.joined(separator: ",")
                
                cell.lblSalon.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? orders[indexPath.item].salon_name_ar : orders[indexPath.item].salon_name_en
            }
            
            
            
            return cell
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.recomsCellId, for: indexPath) as! StoreCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0{
            return CGSize(width: 270, height: 72)
        }else{
            return CGSize(width: 210, height: 190)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.appointmentDetails) as! AppointmentDetailsViewController
        vc.appointments = self.orders[indexPath.item]
        vc.isReorde = true
        self.navigationController?.pushViewController(vc, animated: true)

    }
}
