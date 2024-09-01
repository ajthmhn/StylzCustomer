//
//  collectionViewHandler_SearchView.swift
//  StylezUser
//
//  Created by mac on 19/03/2024.
//

import Foundation
import UIKit

extension  SearchViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return employeeList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: VCConst.stylistCellId, for: indexPath) as! BarberColCell
       
        cell.employee = employeeList[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 8, height: 170)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveToServiceDetails(index: indexPath.row)
    }
    
}


//MARK: - navigation
extension SearchViewController{

    func moveToServiceDetails(index:Int){
        //print("moving to service details view")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.serviceDetail) as! ServiceDetailsViewController
        vc.modalPresentationStyle = .popover
        vc.selectedEmployee = employeeList[index]
        vc.searchView = self
        vc.isEmployee = true
        
        
        //print("not passing branch id: \(self.employeeList[0].branchId ?? 0)")
     vc.branchID = self.employeeList[index].branchId ?? 0
    
//        if isStylist == false, self.employeeList.count>0{
//        //    vc.branchID = self.employeeList[0].branchId ?? 0
//            //     vc.isSearching = true
//          //print("~is stylist is false")
//            vc.branchID = self.employeeList[index].branchId ?? 0
//          }
//        else{
//            //print("not passing branch id: \(self.employeeList[0].branchId ?? 0)")
//            vc.branchID = self.employeeList[index].branchId ?? 0
//        
//        }
//        
        //   vc.isWalkins = self.isWalkin
        self.present(vc, animated: true)
    
    }

}
