//
//  CollectionView_ServiceDetails.swift
//  StylezUser
//
//  Created by mac on 17/03/2024.
//

import Foundation
import UIKit


//MARK: - collection view

extension  ServiceDetailsViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedService == nil{
            return selectedEmployee?.services.count ?? 0
        }else{
            //MARK: - 31 mar - employees
            //return selectedService?.employees.count ?? 0
            return employeeArraay.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.cellId, for: indexPath) as! BarberColCell
        
        if selectedService == nil{

        let service = selectedEmployee?.services[indexPath.row]
            cell.service = service
        
          if selectedBarber == indexPath.item{
              cell.setSelectedBarber()
          }else{
              cell.setDefaultBarbercolor()
          }
        
         }
        else{
         
            let service = employeeArraay[indexPath.row]
            cell.serviecEmployee = service
            
            cell.lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(selectedService?.amount ?? "")"
            
            
            if selectedBarber == indexPath.item{
                cell.setSelectedBarber()
            }else{
                cell.setDefaultBarbercolor()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 114, height: 155)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedService == nil{
            let attrs3 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attrs4 = [NSAttributedString.Key.font : UIFont(name: "Poppins-Bold", size: 16.0)!, NSAttributedString.Key.foregroundColor : UIColor.white]
            let attributedString3 = NSMutableAttributedString(string:"\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "add_basket", comment: "")) - ", attributes:attrs3 as [NSAttributedString.Key : Any])
            //let price = String.init(format: "%.2f", trensingProducts[indexPath.item].offer_price ?? 0.0)
            let attributedString4 = NSMutableAttributedString(string:"\(selectedEmployee?.services[indexPath.row].amount ?? "") \(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: ""))", attributes:attrs4 as [NSAttributedString.Key : Any])
            attributedString3.append(attributedString4)
            lblPrice.attributedText = attributedString3
        }
        
        selectedBarber = indexPath.item
        collectionView.reloadData()
    }
}

extension UILabel {
    func getSize(constrainedWidth: CGFloat) -> CGSize {
        return systemLayoutSizeFitting(CGSize(width: constrainedWidth, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
