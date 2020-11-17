//
//  InvoiceListViewController.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
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
        self.labelOrderId.text = "Order ID: " + aInvoiceList.fld_invoice_no
        self.labelDate.text = aInvoiceList.fld_order_date.orderListDate()
        self.labelTotalAmount.text = "₹ " + aInvoiceList.fld_order_amt
        self.labelSuplier.text = "_"
        self.layoutIfNeeded()
    }
}

class InvoiceListViewController: BaseViewController {
    @IBOutlet weak var tableViewInvoice: UITableView!

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
