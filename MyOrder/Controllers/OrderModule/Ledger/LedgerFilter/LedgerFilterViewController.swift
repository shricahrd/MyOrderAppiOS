//
//  LedgerFilterViewController.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit
class LedgerFilterViewController: BaseViewController {
    @IBOutlet weak var textFieldledgerName: UITextField!
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var textFieldTo: UITextField!
   
    @IBOutlet weak var buttonPurchase: UIButton!
    @IBOutlet weak var buttonSale: UIButton!
    
    var aLedgerFilterViewModel = LedgerFilterViewModel()
    var aLedgerList : [LedgerList] = []
    var aType = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.buttonPurchase.setImage(#imageLiteral(resourceName: "checkRound"), for: .normal)
        self.buttonSale.setImage(#imageLiteral(resourceName: "uncheckRound"), for: .normal)
        self.buttonPurchase.setTitle("Purchase Ledger", for: .normal)
        self.buttonSale.setTitle("Sale Ledger", for: .normal)
        self.buttonPurchase.isHidden = false
        self.buttonSale.isHidden = false
        if UserModel.shared.aSelectedUserType == .retailer {
            self.buttonPurchase.isHidden = false
            self.buttonSale.isHidden = true
            self.aType = 0
            self.buttonPurchase.setTitle("Purchase Ledger", for: .normal)
            self.buttonSale.setTitle("Sale Ledger", for: .normal)
        }else if UserModel.shared.aSelectedUserType == .manufacture {
            self.aType = 1
            self.buttonPurchase.isHidden = false
            self.buttonSale.isHidden = true
            self.buttonPurchase.setTitle("Sale Ledger", for: .normal)
        }
        self.getLedgerListServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
//    override func actionOnLeftIcon() {
//        self.navigationController?.popViewController(animated: true)
//    }
    @IBAction func actionOnPurchase(_ sender: Any) {
        self.aType = 0
        self.textFieldledgerName.text = ""
        self.buttonPurchase.setImage(#imageLiteral(resourceName: "checkRound"), for: .normal)
        self.buttonSale.setImage(#imageLiteral(resourceName: "uncheckRound"), for: .normal)
        self.getLedgerListServiceCall()
    }
    @IBAction func actionOnSale(_ sender: Any) {
        self.aType = 1
        self.textFieldledgerName.text = ""
        self.buttonPurchase.setImage(#imageLiteral(resourceName: "uncheckRound"), for: .normal)
        self.buttonSale.setImage(#imageLiteral(resourceName: "checkRound"), for: .normal)
        self.getLedgerListServiceCall()
    }
    @IBAction func actionOnLeaderName(_ sender: Any) {
        if let aListPicker = ListPicker.getController(story: "Order")  as? ListPicker {
            var aString: [String] = []
            self.aLedgerList.forEach { object in
                aString.append(object.business_name)
            }
            if self.textFieldledgerName.text?.isEmpty == true {
                self.textFieldledgerName.text = aString.first ?? ""
            }
            aListPicker.initializeWithTitleController(parent: self, list: aString, title: "Select Ledger Name") { (str) in
                if str.isEmpty == false {
                    self.textFieldledgerName.text = str
                }
            }
        }
    }
    @IBAction func actionOnFrom(_ sender: Any) {
        if let aDatePicker = DatePicker.getController(story: "Order")  as? DatePicker {
            aDatePicker.initializeWithTitleController(parent: self, title: "Select From Date") { (date) in
                self.textFieldFrom.text = date.getInvoiceDate()
            }
        }
    }
    @IBAction func actionOnTo(_ sender: Any) {
        if let aDatePicker = DatePicker.getController(story: "Order")  as? DatePicker {
            aDatePicker.initializeWithTitleController(parent: self, title: "Select To Date") { (date) in
                self.textFieldTo.text = date.getInvoiceDate()
            }
        }
    }
    @IBAction func actionOnSubmit(_ sender: Any) {
        if textFieldledgerName.text?.isEmpty != true {
            if let aLedgerListViewController = LedgerListViewController.getController(story: "Order")  as? LedgerListViewController {
                aLedgerListViewController.aFromDate = self.textFieldFrom.text!
                aLedgerListViewController.aToDate = self.textFieldTo.text!
                aLedgerListViewController.aType = self.aType
                
                self.aLedgerList.forEach { object in
                    if textFieldledgerName.text == object.business_name {
                        aLedgerListViewController.aLedgerId = object.id
                        aLedgerListViewController.azoneassign_panel_type = object.zoneassign_panel_type
                    }
                }
                self.navigationController?.pushViewController(aLedgerListViewController, animated: true)
            }
        }else {
            self.showAlartWith(message: "Please select name")
        }
    }
}
extension LedgerFilterViewController {
    func getLedgerListServiceCall() {
        self.showActivity()
        self.aLedgerFilterViewModel.getLedgerListServiceCall(type: self.aType){ (model) in
            self.hideActivity()
            self.aLedgerList = model
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
