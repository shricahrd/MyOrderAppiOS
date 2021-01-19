//
//  OrderDetailsViewController.swift
//  MyOrder
//
//  Created by sourabh on 30/10/20.
//

import UIKit
class OrderDetailsViewController: BaseViewController {
    @IBOutlet weak var labelOrderNo: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var buttonMore: BorderButton!
    @IBOutlet weak var viewApproved: BorderView!
    @IBOutlet weak var viewDelivered: BorderView!
    @IBOutlet weak var labelProcess: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var tableViewOrder: UITableView!
    @IBOutlet weak var constraintTableOrderHeight: NSLayoutConstraint!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labeltotalAmount: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var labelNetAmount: UILabel!
    @IBOutlet weak var labelSupplierName: UILabel!
    @IBOutlet weak var labelTitleDeliver: UILabel!
    @IBOutlet weak var labelTitleApprove: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonRiseIssue: BorderButton!
    var viewTitle = "My Orders"

    var aMyOrders = MyOrders()
    var aOrderServiceType: OrderServiceType = .myorder
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.uiUpdate(aMyOrders: aMyOrders)
        self.labelTitle.text = viewTitle

        if self.aOrderServiceType != .myorder {
            self.buttonRiseIssue.setTitle("View Issue", for: .normal)
        }else {
            self.buttonRiseIssue.setTitle("Rise Issue", for: .normal)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    func uiUpdate(aMyOrders: MyOrders) {
        self.viewBorder.shadowWithRadius()
        self.labelOrderNo.text = "Order No." + aMyOrders.fld_zoneassign_order_id
        self.labelQty.text = aMyOrders.fld_order_qty
        self.labelDate.text = aMyOrders.fld_order_date.orderListDate()
        self.labelPrice.text = "₹ " + aMyOrders.fld_order_total_amt
        self.updateHeight()
        self.labelSupplierName.text = aMyOrders.fld_supplier_name
        self.labelAddress.text = aMyOrders.fld_order_shipping_address + ", " +
            aMyOrders.fld_order_shipping_state_name + ", " +
            aMyOrders.fld_order_shipping_city_name + ", " +
            aMyOrders.fld_order_shipping_area_name + ", " +
            aMyOrders.fld_order_shipping_zip
        self.labelDiscount.text = aMyOrders.fld_coupon_amt
        self.labeltotalAmount.text = aMyOrders.fld_order_total_amt
        let amount : Int = Int(aMyOrders.fld_order_total_amt) ?? 0
        let dicount : Int = Int(aMyOrders.fld_coupon_amt) ?? 0
        self.labelNetAmount.text = String(amount - dicount)
        
        
        //        pending=0
        //        In Queue=1
        //        Dispatch=2
        //        Transit=8
        //        Delivered=3
        //        Cancel=4
        

        self.labelTitleApprove.isHidden = false
        self.labelTitleDeliver.isHidden = false
        self.viewApproved.isHidden = false
        self.labelProcess.isHidden = false
        self.viewDelivered.isHidden = false
        
        if aMyOrders.fld_order_status == 1 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
            self.buttonMore.setTitle("Approved", for: .normal)
        }else if aMyOrders.fld_order_status == 2 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppGreen")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
            self.buttonMore.setTitle("Dispatched", for: .normal)
        }else if aMyOrders.fld_order_status == 3 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppGreen")
            viewDelivered.backgroundColor = UIColor(named: "AppGreen")
            self.buttonMore.setTitle("Delivered", for: .normal)
        }else if aMyOrders.fld_order_status == 4 {
            self.labelTitleApprove.isHidden = true
            self.labelTitleDeliver.isHidden = true
            self.viewApproved.isHidden = true
            self.labelProcess.isHidden = true
            self.viewDelivered.isHidden = true
            self.buttonMore.setTitle("Canceled", for: .normal)
        }else if aMyOrders.fld_order_status == 8 {
            self.labelTitleApprove.isHidden = true
            self.labelTitleDeliver.isHidden = true
            self.viewApproved.isHidden = true
            self.labelProcess.isHidden = true
            self.viewDelivered.isHidden = true
            self.buttonMore.setTitle("Transit", for: .normal)
        }else {
            viewApproved.backgroundColor = UIColor(named: "AppCellGray")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
            self.buttonMore.setTitle("Pending", for: .normal)
        }
    }

    @IBAction func actionOnRiseIssue(_ sender: Any) {
        if let  aIssuesListViewController = IssuesListViewController.getController(story: "Order")  as? IssuesListViewController {
            aIssuesListViewController.productId = aMyOrders.fld_zoneassign_order_id
            aIssuesListViewController.aOrderServiceType = self.aOrderServiceType
            self.navigationController?.pushViewController(aIssuesListViewController, animated: true)
        }
    }
}
extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = aMyOrders.aCartLists.count
        return count
    }
    func updateHeight(){
        var cellHeight = 0
        aMyOrders.aCartLists.forEach { aaCartList in
            cellHeight = cellHeight + (aaCartList.colorsizelist.count * 90) + 75
            aaCartList.colorsizelist.forEach { colorsList in
                var flag = false
                if colorsList.isSizeVisible == true {
                    colorsList.size_list.forEach { sizes in
                        flag = true
                        cellHeight = cellHeight + 60
                    }
                    if flag == true {
                        cellHeight = cellHeight + 35
                    }
                }
            }
        }
        self.constraintTableOrderHeight.constant = CGFloat(cellHeight)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell") as! CartViewCell
        cell.setCellData(aCartList: aMyOrders.aCartLists[indexPath.row]) { (indexOfColorCell) in
            self.aMyOrders.aCartLists[indexPath.row].colorsizelist[indexOfColorCell].isSizeVisible = !self.aMyOrders.aCartLists[indexPath.row].colorsizelist[indexOfColorCell].isSizeVisible
            self.updateHeight()
            self.tableViewOrder.reloadData()
        } aColorSizeDelete: { (colorIndex, colorSizeIndex) in
        } aColorSizeUpdate: { (colorIndex, colorSizeIndex, qty) in
        } aAdditionalDelete: { (index) in
        } aAdditionalUpdate: { (index, qty) in
        }
        cell.buttonCancelOrder.tag = indexPath.row
        cell.buttonCancelOrder.addTarget(self, action: #selector(self.actionOnCancel), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    @objc func actionOnCancel(sender: UIButton) {
        if let  aOrderCancelViewController = OrderCancelViewController.getController(story: "Order")  as? OrderCancelViewController {
            aOrderCancelViewController.aCartList = aMyOrders.aCartLists[sender.tag]
            self.navigationController?.pushViewController(aOrderCancelViewController, animated: true)
        }
    }
}
