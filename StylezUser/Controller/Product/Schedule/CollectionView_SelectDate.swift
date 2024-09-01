//
//  CollectionView_SelectDate.swift
//  StylezUser
//
//  Created by mac on 18/03/2024.
//

import Foundation
import UIKit

extension SelectDateViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  timings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VCCont.cellId, for: indexPath) as! CategColCell
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.lblItem.text = timings[indexPath.item].formatted_start_time
        
        if selectedTime == indexPath.item{
            animationScaleEffectSingle(view: cell)
            cell.lblItem.textColor = UIColor.white
            cell.backgroundColor = getThemeColor()
            cell.layer.borderWidth = 0
        }else{
            cell.lblItem.textColor = UIColor.black
            cell.backgroundColor = UIColor.white
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 10, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTime = indexPath.item
        collectionView.reloadData()
    }
}


