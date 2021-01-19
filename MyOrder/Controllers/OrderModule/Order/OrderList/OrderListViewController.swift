//
//  OrderListViewController.swift
//  MyOrder
//
//  Created by sourabh on 29/10/20.
//

import UIKit

enum OrderServiceType  {
    case myorder
    case delivered
    case dispatched
}

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
    @IBOutlet weak var labelTitleApprove: UILabel!
    @IBOutlet weak var labelTitleDeliver: UILabel!
    @IBOutlet weak var labelCancel: UILabel!
    
    func setCellDate(aMyOrders: MyOrders) {
        self.viewBorder.shadowWithRadius()
        self.labelOrderNo.text = "Order No: " + aMyOrders.fld_zoneassign_order_id
        self.labelQty.text = aMyOrders.fld_order_qty
        self.labelDate.text = aMyOrders.fld_order_date.orderListDate()
        self.labelPrice.text = "₹ " + aMyOrders.fld_order_total_amt
        self.labelSupliername.text = aMyOrders.fld_supplier_name
        self.layoutIfNeeded()
        
//        pending=0
//        In Queue=1
//        Dispatch=2
//        Transit=8
//        Delivered=3
//        Cancel=4

        self.labelCancel.isHidden = true
        self.labelTitleApprove.isHidden = false
        self.labelTitleDeliver.isHidden = false
        self.viewApproved.isHidden = false
        self.labelProcess.isHidden = false
        self.viewDelivered.isHidden = false

        if aMyOrders.fld_order_status == 1 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
        }else if aMyOrders.fld_order_status == 2 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppGreen")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
        }else if aMyOrders.fld_order_status == 3 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppGreen")
            viewDelivered.backgroundColor = UIColor(named: "AppGreen")
        }else if aMyOrders.fld_order_status == 4 {
            self.labelCancel.isHidden = false
            self.labelTitleApprove.isHidden = true
            self.labelTitleDeliver.isHidden = true
            self.viewApproved.isHidden = true
            self.labelProcess.isHidden = true
            self.viewDelivered.isHidden = true
        }else {
            viewApproved.backgroundColor = UIColor(named: "AppCellGray")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
        }
    }
    
    func setCellData(aRedeemOrders: RedeemOrders) {
        self.viewBorder.shadowWithRadius()
        self.labelOrderNo.text = "Order No: " + aRedeemOrders.fld_order_no
        self.labelQty.text = aRedeemOrders.fld_order_qty.description
        self.labelDate.text = aRedeemOrders.fld_order_date.orderListDate()
        self.labelPrice.text = aRedeemOrders.fld_order_total_amt.description
    }
}

class OrderListViewController: BaseViewController {
    @IBOutlet weak var tableViewOrderList: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var labelTitle: UILabel!

    var aOrderListViewModel = OrderListViewModel()
    var aOrderListModel = OrderListModel()
    var currentPageNo = 0
    var isLoading: Bool = false
    var aOrderServiceType : OrderServiceType = .myorder
    var viewTitle = "My Orders"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
        self.tableViewOrderList.separatorColor = UIColor.clear
        self.labelTitle.text = viewTitle
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
        self.getOrdersServiceCall()
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
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
            aOrderDetailsViewController.viewTitle = self.viewTitle
            aOrderDetailsViewController.aOrderServiceType = self.aOrderServiceType
            self.navigationController?.pushViewController(aOrderDetailsViewController, animated: true)
        }
    }
}
extension OrderListViewController {
    func getOrdersServiceCall() {
        self.showActivity()
        self.aOrderListViewModel.aGetOrdersListServiceCall(afld_page_no: self.currentPageNo, aOrderServiceType: self.aOrderServiceType) { (model) in
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
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
extension OrderListViewController: UITextFieldDelegate {
  
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
