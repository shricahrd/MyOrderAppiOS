//  ShippingAddressVC.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class ShippingAddressVC: UIViewController {
    var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    @IBOutlet var tableMain: UITableView!
    
    @IBOutlet var btnPlus: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        tableMain.register(UINib(nibName: "ShippingAddressCell", bundle: nil), forCellReuseIdentifier: "ShippingAddressCell")
        tableMain.delegate = self
        tableMain.dataSource = self
        tableMain.separatorStyle = .none
        btnPlus.layer.cornerRadius = 60/2
        btnPlus.clipsToBounds = true
    }

    @IBAction func clickBtnPlus(_ sender: Any) {
    }
}
extension ShippingAddressVC:UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146
    }
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShippingAddressCell", for: indexPath as IndexPath) as! ShippingAddressCell
        cell.selectionStyle = .none
        cell.viewBG.layer.cornerRadius = 10
        cell.viewBG.clipsToBounds = true
        
        //  cell.imgpic.image = UIImage(named: arrayImg[indexPath.row])
        //  cell.imgpic.contentMode = .scaleAspectFit
          //cell.lblName.text = arrayData[indexPath.row]
        cell.lblName.text = "Rakeshkushwaha"
        cell.lblAddress.text = "23Ahoknagar delhi"


        cell.btnEddit.addTarget(self, action: #selector(btnEddit), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(btnDelete), for: .touchUpInside)
        cell.btnCheckUnckeck.addTarget(self, action: #selector(btnCheckUnckeck), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        
    }
    @objc func btnEddit(sender: UIButton!) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    @objc func btnDelete(sender: UIButton!) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
//        self.navigationController?.pushViewController(VC, animated: true)
    }
    @objc func btnCheckUnckeck(sender: UIButton!) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "GroupJoin") as! GroupJoin
//        self.navigationController?.pushViewController(VC, animated: true)
    }
   
}
