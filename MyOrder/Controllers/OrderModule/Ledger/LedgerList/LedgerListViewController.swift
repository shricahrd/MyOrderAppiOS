//
//  LedgerListViewController.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit
class LedgerListViewController: BaseViewController {
    
    var aLedgerListViewModel = LedgerListViewModel()
   
    var aLedgerId: Int = 0
    var aFromDate: String = ""
    var aToDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.getLedgerServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    @IBAction func actionOnFilter(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        if let aLedgerFilterViewController = LedgerFilterViewController.getController(story: "Order")  as? LedgerFilterViewController {
//            self.navigationController?.pushViewController(aLedgerFilterViewController, animated: true)
//        }
    }
}
extension LedgerListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.count > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
                    aProductListViewController.searchText = textField.text!
                    self.navigationController?.pushViewController(aProductListViewController, animated: true)
                }
            }
        }
    }
}
extension LedgerListViewController {
    func getLedgerServiceCall() {
        self.showActivity()
        self.aLedgerListViewModel.getLedgerServiceCall(afld_date_from: self.aFromDate,
                                                       afld_date_to: self.aToDate,
                                                       aLedger_party_id: self.aLedgerId) {(model) in
            self.hideActivity()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
