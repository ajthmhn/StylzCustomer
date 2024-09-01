//
//  RatingsTableViewCell.swift
//  Bilz
//
//  Created by Me on 1/28/24.
//

import UIKit
import StylesWebKit

protocol RatingsDelegate{
    func rateOrder(tag:Int, currentIndex:Int)
}

class RatingsTableViewCell: UITableViewCell {
    
    @IBOutlet var itemName_lbl: UILabel!
    @IBOutlet var itemImg_lbl: UIImageView!
    @IBOutlet var ratingBtnImg: [UIImageView]!
    @IBOutlet var ratingBtns: [UIButton]!
    @IBOutlet var ratingView: [UIView]!
  
    var delegate:RatingsDelegate?
    var currentIndex = 0
    var rating = 1
  
    var empolyeeData : Employee?{
        didSet{
            detailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    @IBAction func onClickRatingBtn(_ sender: UIButton) {
           self.delegate?.rateOrder(tag: sender.tag, currentIndex:currentIndex)
    }
    
    func detailConfiguration(){
        guard let employee = empolyeeData else {return}
    
    //print("empllyee :\(employee)")
        itemName_lbl.text = employee.first_name
        
        setRatingImg(rating:employee.empRating)
        
        setImage(imageView: itemImg_lbl, url: employee.image ?? "")
    }

    func setRatingImg(rating:Int){
       for i in 0...ratingBtnImg.count-1 {
            i<=rating-1 ?
            (self.ratingBtnImg[i].tintColor = getRatingColor(index: rating)) :
            (self.ratingBtnImg[i].tintColor = getRatingColor(index: -1))
        }
        animationScaleEffectSingle(view: self.ratingView[rating - 1])
      }
    
    func getRatingColor(index:Int) -> UIColor? {
        switch index{
        case 1,2:
            return K.Color.star2
        case 3:
            return K.Color.star3
        case 4,5:
            return K.Color.star5
        default:
            return K.Color.star
        }
    }
    
    
}
