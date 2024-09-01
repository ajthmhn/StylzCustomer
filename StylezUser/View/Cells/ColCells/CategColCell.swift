//
//  CategColCell.swift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit
import StylesWebKit
class CategColCell: UICollectionViewCell {
    @IBOutlet var lblItem: UILabel!
    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var viewBg: UIView!
    
    //services
    var category: Categories?{
        didSet{
            configCategory()
        }
    }
    var index = -1
    
}


//MARK: - service view controller
extension CategColCell{
    
    func configCategory(){
        guard let category = category else { return }
        
        configCellUI()
        
        lblItem.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? category.name_ar : category.name_en
    }
    
    func configCellUI(){
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    func setCellSelected(){
        backgroundColor = getThemeColor()
        lblItem.textColor = UIColor.white
        
    }
    
    func setCellUnselected(){
        backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        lblItem.textColor = UIColor.black
    }

}
