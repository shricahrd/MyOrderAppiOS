//
//  InvoiceListViewController.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit

class InvoiceListCell: UITableViewCell {
    @IBOutlet weak var labelOrderNo: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelSuplier: UILabel!
    @IBOutlet weak var buttonPayNow: BorderButton!
    @IBOutlet weak var labelOrderId: UILabel!
    @IBOutlet weak var labelTotalAmount: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    
    func setCellData(aInvoiceList: InvoiceList) {
        self.viewBorder.shadowWithRadius()
        self.labelOrderNo.text = "Order No: #" + aInvoiceList.fld_order_no
        self.labelOrderId.text = "Invoice No: " + aInvoiceList.fld_invoice_no
        self.labelDate.text = aInvoiceList.fld_order_date.orderListDate()
        self.labelTotalAmount.text = "₹ " + aInvoiceList.fld_order_amt
        self.labelSuplier.text = aInvoiceList.fld_supplier_name
        self.layoutIfNeeded()
        self.buttonPayNow.isHidden = true
    }
}

class InvoiceListViewController: BaseViewController {
    @IBOutlet weak var tableViewInvoice: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    var aInvoiceListViewModel = InvoiceListViewModel()
    var aInvoiceListModel = InvoiceListModel()
    var currentPageNo = 0
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.getOrdersInvoiceListServiceCall()
        self.tableViewInvoice.separatorColor = UIColor.clear
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
}
extension InvoiceListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aInvoiceListModel.aInvoiceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceListCell") as! InvoiceListCell
        cell.setCellData(aInvoiceList: aInvoiceListModel.aInvoiceList[indexPath.row])
        cell.buttonPayNow.tag = indexPath.row
        cell.buttonPayNow.addTarget(self, action: #selector(self.actionOnPayNow), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        230
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.y
        if contentOffsetX >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
            guard !self.isLoading else { return }
            self.isLoading = true
            self.currentPageNo += 1
            self.getOrdersInvoiceListServiceCall()
        }
    }
    @objc func actionOnPayNow(sender: UIButton) {
        if let aInvoicePayViewController = InvoicePayViewController.getController(story: "Order")  as? InvoicePayViewController {
            aInvoicePayViewController.aInvoiceList = aInvoiceListModel.aInvoiceList[sender.tag]
            self.navigationController?.pushViewController(aInvoicePayViewController, animated: true)
        }
    }
}

extension InvoiceListViewController {
    func getOrdersInvoiceListServiceCall() {
        self.showActivity()
        self.aInvoiceListViewModel.aGetInvoiceListServiceCall(afld_page_no: self.currentPageNo) { (model) in
            self.hideActivity()
            if self.isLoading == true {
                self.aInvoiceListModel.aInvoiceList.append(contentsOf: model.aInvoiceList)
                self.isLoading = false
            }else {
                self.aInvoiceListModel = model
            }
            self.tableViewInvoice.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}

extension InvoiceListViewController: UITextFieldDelegate {
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
