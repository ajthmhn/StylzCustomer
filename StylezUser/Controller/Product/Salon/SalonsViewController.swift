//
//  SalonsViewController.swift
//  StylezUser
//
//  Created by Ajith Mohan on 14/08/23.
//

import UIKit
import StylesWebKit

class SalonsViewController: BaseViewController {

    struct VCConst {
        static let salonListCellId = "salon_list_cell_id"
    }
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tblSaloons: UITableView!
    @IBOutlet weak var lblHead: UILabel!


    var salons = [Salons]()
    var serviceId = 0
    var isMySalons = false
  
    var isFromAppdelegate = false
    var branchId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnBack.tintColor = getThemeColor()
        
        btnBack.setImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "ar" ? "back_right" : "back_btn"), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
}



extension SalonsViewController{

    //MARK: - fetching data from server

    func fetchData(){
        
        if isFromAppdelegate{
            getAllBarbers()
        }
        else{
            if serviceId != 0{
                //print("getting services")
                // - getting service id from searchViewController's services list
                getTop10Salons()
            }
            else{
                if isMySalons == true{
                    //- fetching salons from server - fav
                    //print("getting salons")
                    getMySalons()
                }else{
                    // -  got salons list from home view - top10salons
                    //print("got salons from home view salons")
                    updateSalonView()
                }
            }
        }
    }
    
    
    //MARK: - update salon  view
    func updateSalonView(){
        self.tblSaloons.reloadData()
        let label =  getNoDataLabel(tableORColView: self.tblSaloons)
        
        if self.salons.count == 0{
            self.tblSaloons.backgroundView = label
        }else{
            self.tblSaloons.backgroundView = nil
        }
    }
   
    
    //MARK: - navigation

    func moveToServicesView(index:Int){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: stryBrdId.service) as! ServiceViewController
        vc.salon = salons[index]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



//MARK: - table view
extension SalonsViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VCConst.salonListCellId) as! SalonListCell
        
        cell.salon = salons[indexPath.row]
        
        return  cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        moveToServicesView(index: indexPath.row)}
    
    
}
