//
//  CategoryViewController.swift
//  StylezUser
//
//  Created by mac on 15/03/2024.
//

import UIKit
import StylesWebKit

class CategoryViewController: BaseViewController {
    
    struct VCConst {
        static let cellId = "category_cell_id"
    }
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var colCategory: UICollectionView!
    @IBOutlet weak var lblHead: UILabel!
    @IBOutlet weak var tblList: UITableView!
    
    
    var categories = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnBack.tintColor = getThemeColor()
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
     
        getCategory()
        
        lblHead.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "select_category", comment: "")
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}



//MARK: - table view

extension CategoryViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.cellId) as! SalonListCell
        
        cell.lblName.text = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? categories[indexPath.item].name_ar :  categories[indexPath.item].name_en
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //
        moveToShopsView(index: indexPath.item)
    }
    
    func moveToShopsView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.shops) as! ShopsViewController
       
        vc.categoryId = self.categories[index].id ?? 0
        
        vc.name = LocalizationSystem.sharedInstance.getLanguage() == "ar" ? categories[index].name_ar ?? "" :  categories[index].name_en ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

