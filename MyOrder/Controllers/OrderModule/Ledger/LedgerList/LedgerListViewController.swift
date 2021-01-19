//
//  LedgerListViewController.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit

class LedgerListCell: UITableViewCell {
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    
    func setPayment(aLedgerPaymentData: LedgerPaymentData){
        self.labelDate.text = aLedgerPaymentData.created_at.components(separatedBy: " ").first
        self.labelAmount.text = "₹" + aLedgerPaymentData.vendor_payment_amt.description
    }
    func setPurchase(aLedgerPurchaseData: LedgerPurchaseData){
        self.labelDate.text = aLedgerPurchaseData.order_date.components(separatedBy: " ").first
        self.labelAmount.text = "₹" + aLedgerPurchaseData.total_product_amt.description
    }
    func setSale(aLedgerSaleData: LedgerSaleData){
        self.labelDate.text = aLedgerSaleData.order_date.components(separatedBy: " ").first
        self.labelAmount.text = "₹" + aLedgerSaleData.total_product_amt.description
    }
}

class LedgerListViewController: BaseViewController {
    
    @IBOutlet weak var tableViewledger: UITableView!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var textFieldSearch: UITextField!
    var aLedgerListViewModel = LedgerListViewModel()
    var aLedgerId: Int = 0
    var aFromDate: String = ""
    var aToDate: String = ""
    var aType: Int = 0
    var azoneassign_panel_type: Int = 0
    var selectedTab = 0
    var aLedgerData : LedgerData = LedgerData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.getLedgerServiceCall()
        self.selectButtonOne()
        self.buttonOne.setTitle("Payment", for: .normal)
        self.buttonTwo.setTitle( (aType == 0 ? "Purchase" : "Sale"), for: .normal)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
    }
    @IBAction func actionOnFilter(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        if let aLedgerFilterViewController = LedgerFilterViewController.getController(story: "Order")  as? LedgerFilterViewController {
//            self.navigationController?.pushViewController(aLedgerFilterViewController, animated: true)
//        }
    }
    @IBAction func actionOnButtonOne(_ sender: Any) {
        selectButtonOne()
    }
    @IBAction func acrionOnButtonTwo(_ sender: Any) {
        selectButtonTwo()
    }
    
    func selectButtonOne(){
        self.buttonOne.setTitleColor(UIColor(named: "AppLightBlue"), for: .normal)
        self.buttonTwo.setTitleColor(UIColor(named: "AppBlack"), for: .normal)
        self.labelName.text = self.aLedgerData.aLedgerPartyInfo.business_name
        self.labelBalance.text = "₹" + self.aLedgerData.balance_amt.description
        self.selectedTab = 0
        self.tableViewledger.reloadData()
    }
    func selectButtonTwo(){
        self.buttonTwo.setTitleColor(UIColor(named: "AppLightBlue"), for: .normal)
        self.buttonOne.setTitleColor(UIColor(named: "AppBlack"), for: .normal)
        self.selectedTab = 1
        self.tableViewledger.reloadData()
    }

}
extension LedgerListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        if result.contains("\n") { return true}
        if result.count > 0 {
            if let frame = textField.superview?.convert(textField.frame, to: nil) {
                self.showSearchList(top: frame.maxY + 20, text: result)
            }
        }else {
            self.hideSearchList()
        }
        return true
    }
    func goToSearchResult(text: String){
        if let  aProductListViewController = ProductListViewController.getController(story: "Dashboard")  as? ProductListViewController {
            aProductListViewController.searchText = text
            self.navigationController?.pushViewController(aProductListViewController, animated: true)
        }
    }
}
extension LedgerListViewController {
    func getLedgerServiceCall() {
        self.showActivity()
        self.aLedgerListViewModel.getLedgerServiceCall(ledger_type: self.aType,
                                                       afld_date_from: self.aFromDate,
                                                       afld_date_to: self.aToDate,
                                                       aLedger_party_id: self.aLedgerId, azoneassign_panel_type: self.azoneassign_panel_type) {(model) in
            self.hideActivity()
            self.aLedgerData = model
            self.selectButtonOne()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
extension LedgerListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTab == 0 {
            return self.aLedgerData.aLedgerPaymentData.count
        }else {
            if aType == 0 {
                return self.aLedgerData.aLedgerPurchaseData.count
            }else {
                return self.aLedgerData.aLedgerSaleData.count
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LedgerListCell") as! LedgerListCell
        if selectedTab == 0 {
            cell.setPayment(aLedgerPaymentData: self.aLedgerData.aLedgerPaymentData[indexPath.row])
        }else {
            if aType == 0 {
                cell.setPurchase(aLedgerPurchaseData: self.aLedgerData.aLedgerPurchaseData[indexPath.row])
            } else {
                cell.setSale(aLedgerSaleData: self.aLedgerData.aLedgerSaleData[indexPath.row])
            }
        }
        return cell
    }
}
