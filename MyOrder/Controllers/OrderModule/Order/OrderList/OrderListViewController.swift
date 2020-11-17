//
//  OrderListViewController.swift
//  MyOrder
//
//  Created by gwl on 29/10/20.
//

import UIKit

class OrderListCell: UITableViewCell {
    @IBOutlet weak var labelOrderNo: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelSupliername: UILabel!
    @IBOutlet weak var buttonMore: BorderButton!
    @IBOutlet weak var viewApproved: BorderView!
    @IBOutlet weak var viewDelivered: BorderView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var labelProcess: UILabel!

    func setCellDate(aMyOrders: MyOrders) {
        self.viewBorder.shadowWithRadius()
        self.labelOrderNo.text = "Order No: " + aMyOrders.fld_order_no
        self.labelQty.text = aMyOrders.fld_order_qty
        self.labelDate.text = aMyOrders.fld_order_date.orderListDate()
        self.labelPrice.text = "₹ " + aMyOrders.fld_order_total_amt
        self.labelSupliername.text = "_"
        self.layoutIfNeeded()
        if aMyOrders.fld_order_status == 1 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
        }else if aMyOrders.fld_order_status == 4 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppGreen")
            viewDelivered.backgroundColor = UIColor(named: "AppGreen")
        }else {
            viewApproved.backgroundColor = UIColor(named: "AppCellGray")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
        }
    }
}

class OrderListViewController: BaseViewController {
    @IBOutlet weak var tableViewOrderList: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    var aOrderListViewModel = OrderListViewModel()
    var aOrderListModel = OrderListModel()
    var currentPageNo = 0
    var isLoading: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.tableViewOrderList.separatorColor = UIColor.clear
        self.getOrdersServiceCall()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
}
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aOrderListModel.aMyOrders.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        212
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell") as! OrderListCell
        cell.setCellDate(aMyOrders: aOrderListModel.aMyOrders[indexPath.row])
        cell.buttonMore.tag = indexPath.row
        cell.buttonMore.addTarget(self, action: #selector(self.actionOnMore), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.y
        if contentOffsetX >= (scrollView.contentSize.height - scrollView.bounds.height) - 20 /* Needed offset */ {
            guard !self.isLoading else { return }
            self.isLoading = true
            self.currentPageNo += 1
            self.getOrdersServiceCall()
        }
    }
    @objc func actionOnMore(sender: UIButton) {
        if let aOrderDetailsViewController = OrderDetailsViewController.getController(story: "Order")  as? OrderDetailsViewController {
            aOrderDetailsViewController.aMyOrders = aOrderListModel.aMyOrders[sender.tag]
            self.navigationController?.pushViewController(aOrderDetailsViewController, animated: true)
        }
    }
}
extension OrderListViewController {
    func getOrdersServiceCall() {
        self.showActivity()
        self.aOrderListViewModel.aGetOrdersListServiceCall(afld_page_no: self.currentPageNo) { (model) in
            self.hideActivity()
            if self.isLoading == true {
                self.aOrderListModel.aMyOrders.append(contentsOf: model.aMyOrders)
                self.isLoading = false
            }else {
                self.aOrderListModel = model
            }
            self.tableViewOrderList.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
extension OrderListViewController: UITextFieldDelegate {
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
