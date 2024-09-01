//
//  BarberColswift
//  Stylz
//
//  Created by WC_Macmini on 27/02/23.
//

import UIKit
import StylesWebKit

class BarberColCell: UICollectionViewCell {
    @IBOutlet var imgBarber: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var viewRating: UIView!
    @IBOutlet var imgStar: UIImageView!
    @IBOutlet var viewBg: UIView!
    
    
    //seearch view
    var employee:Employee?{
        didSet{
            configEmployee()
        }
    }
    
    //serviceDetail view
    var serviecEmployee:Employee?{
        didSet{
            configServicesEmployee()
        }
    }
    
    //serviceDetail view
    var service:Services?{
        didSet{
            configService()
        }
    }
    
}

//MARK: - search vieew
extension BarberColCell{
    
    func configEmployee(){
        
        guard let employee = employee else {return}
        
        
        configEmployeeUI()
        
        lblName.text = employee.first_name
        lblRating.text = employee.employee_rating
        
        lblPrice.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? employee.branchNameAr :  employee.branchNameEn
        
        setImage(imageView: imgBarber, url: employee.image ?? "",placeHolderImg: nil)
        
        
    }
    
    
    func configEmployeeUI(){
        
        viewBg.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        viewBg.layer.borderWidth = 0.5
        viewBg.layer.cornerRadius = 8
        viewBg.layer.masksToBounds = true
        
        self.dropShadow(color: UIColor.lightGray)
        // viewBg.dropShadow(color: UIColor.lightGray)
        
        imgStar.tintColor = getThemeColor()
        lblRating.textColor = getThemeColor()
    }
}


//MARK: - service detail vieew
extension BarberColCell{
    
    func configService(){
        
        guard let services = service else {return}
        
        configServiceEmployeeUI()
        
        lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? services.name_ar : services.name_en
        
        lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(services.amount ?? "")"
        
        imgBarber.image = UIImage(named: "test_5")
        
        
        viewRating.isHidden = true
        
        
    }
    
    func setSelectedBarber(){
        backgroundColor = UIColor(hexString: "1B263B")
        lblName.textColor = UIColor.white
        lblPrice.textColor = UIColor.white
        layer.borderWidth = 0
        animationScaleEffectSingle(view: self)
        
    }
    
    func setDefaultBarbercolor(){
        layer.borderWidth = 0.5
        backgroundColor = UIColor.white
        lblName.textColor = UIColor.black
        lblPrice.textColor = UIColor.black
        
    }
    
    func configServiceEmployeeUI(){
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 20
        
        layer.masksToBounds = true
        
        self.dropShadow(color: UIColor.lightGray)
    }
    
}


//MARK: - service detail vieew
extension BarberColCell{
    
    func configServicesEmployee(){
        
        guard let employee = serviecEmployee else {return}
        
        configServiceEmployeeUI()
        
        viewRating.isHidden = false  //false
        
        lblName.text = employee.first_name
        lblRating.text = employee.employee_rating
        
        //lblPrice.text = "\(LocalizationSystem.sharedInstance.localizedStringForKey(key: "sar", comment: "")) \(employee.price ?? "")"
        
        setImage(imageView: imgBarber, url: employee.image ?? "")
        
        imgBarber.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
    }
}
