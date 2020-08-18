//  InvoiceVC.swift
//  MyOrderApp
//  Created by RAKESH KUSHWAHA on 13/07/20.
//  Copyright © 2020 rakesh. All rights reserved.

import UIKit

class InvoiceVC: UIViewController {
    var arrayData = ["Invite Friends", "Fantasy Point System", "How to Play", "HelpDesk","About Us"]
    var screenSize:CGRect = UIScreen.main.bounds
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    @IBOutlet var tableMain: UITableView!
    
    @IBOutlet var btnCart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.screenWidth = screenSize.width
        self.screenHeight = screenSize.height
        self.navigationController?.isNavigationBarHidden = true
        tableMain.register(UINib(nibName: "InvoiceCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
        tableMain.delegate = self
        tableMain.dataSource = self
        tableMain.separatorStyle = .none
    
    }

    @IBAction func clickBtnPlus(_ sender: Any) {
    }
}
extension InvoiceVC:UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath as IndexPath) as! InvoiceCell
        cell.selectionStyle = .none

        
        //  cell.imgpic.image = UIImage(named: arrayImg[indexPath.row])
        //  cell.imgpic.contentMode = .scaleAspectFit
          //cell.lblName.text = arrayData[indexPath.row]
        cell.lblTitale.text = "Rakeshkushwaha"
        cell.lblDate.text = "Invoice No:#0004"
        cell.lblOrderId.text = "OrderID:011111"
        cell.lblSuplier.text = "Suplier:"
        cell.lblSuplierName.text = "Rakeshkumar"
        cell.lblTAmount.text = "Total Amount:"
        cell.lblAmount.text = "22020"
        cell.btnPayNaow.layer.cornerRadius = 15
        cell.btnPayNaow.clipsToBounds = true

        cell.btnPayNaow.addTarget(self, action: #selector(clickPayNaow), for: .touchUpInside)
       
        
        return cell
    }
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        
    }

    @objc func clickPayNaow(sender: UIButton!) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storyBoard.instantiateViewController(withIdentifier: "CreateYourTeam") as! CreateYourTeam
//        self.navigationController?.pushViewController(VC, animated: true)
    }
   
    }
   

