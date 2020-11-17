//
//  LedgerFilterViewController.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit
class LedgerFilterViewController: BaseViewController {
    @IBOutlet weak var textFieldledgerName: UITextField!
    @IBOutlet weak var textFieldFrom: UITextField!
    @IBOutlet weak var textFieldTo: UITextField!
    
    var aLedgerFilterViewModel = LedgerFilterViewModel()
    var aLedgerList : [LedgerList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.getLedgerListServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
//    override func actionOnLeftIcon() {
//        self.navigationController?.popViewController(animated: true)
//    }
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
        if let aLedgerListViewController = LedgerListViewController.getController(story: "Order")  as? LedgerListViewController {
            aLedgerListViewController.aFromDate = self.textFieldFrom.text!
            aLedgerListViewController.aToDate = self.textFieldTo.text!
            self.aLedgerList.forEach { object in
                if textFieldledgerName.text == object.business_name {
                    aLedgerListViewController.aLedgerId = object.id
                }
            }
            self.navigationController?.pushViewController(aLedgerListViewController, animated: true)
        }
    }
}
extension LedgerFilterViewController {
    func getLedgerListServiceCall() {
        self.showActivity()
        self.aLedgerFilterViewModel.getLedgerListServiceCall { (model) in
            self.hideActivity()
            self.aLedgerList = model
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
