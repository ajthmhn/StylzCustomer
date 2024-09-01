//
//  collectionView_ServiceView.swift
//  StylezUser
//
//  Created by mac on 16/03/2024.
//

import Foundation
import UIKit

//MARK: - collectionvoiew

extension ServiceViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.cellId, for: indexPath) as! CategColCell
          
        
        cell.category = categories[indexPath.item]
        
        // setImage(imageView: cell.imgItem, url: categories[indexPath.item].service_category_icon ?? "")
        
        if selectedService == indexPath.item{
            
            animationScaleEffectSingle(view: cell)
            
            cell.setCellSelected()
            
            animationScaleEffectSingle(view: cell)
            
        }
        else{
            cell.setCellUnselected()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
        let label = UILabel(frame: CGRect.zero)
           label.font = UIFont.systemFont(ofSize: 19)
           label.text = "Cutting"
           label.sizeToFit()
        
        return CGSize(width: label.frame.width + 60, height: 40)
    }

        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedService = indexPath.item
        selectedCategoryID = categories[indexPath.row].id ?? 0
        
        collectionView.reloadData()
  
        fetchData(getOnlyServices: true)
    }
}

