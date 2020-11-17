//
//  OrderDetailsViewController.swift
//  MyOrder
//
//  Created by gwl on 30/10/20.
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
    
    var aMyOrders = MyOrders()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.uiUpdate(aMyOrders: aMyOrders)
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
        self.labelOrderNo.text = "Order No." + aMyOrders.fld_order_no
        self.labelQty.text = aMyOrders.fld_order_qty
        self.labelDate.text = aMyOrders.fld_order_date.orderListDate()
        self.labelPrice.text = "₹ " + aMyOrders.fld_order_total_amt
        self.updateHeight()
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
        if aMyOrders.fld_order_status == 1 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
            self.buttonMore.setTitle("Approved", for: .normal)
        }else if aMyOrders.fld_order_status == 4 {
            viewApproved.backgroundColor = UIColor(named: "AppGreen")
            labelProcess.backgroundColor = UIColor(named: "AppGreen")
            viewDelivered.backgroundColor = UIColor(named: "AppGreen")
            self.buttonMore.setTitle("Delivered", for: .normal)
        }else {
            viewApproved.backgroundColor = UIColor(named: "AppCellGray")
            labelProcess.backgroundColor = UIColor(named: "AppCellGray")
            viewDelivered.backgroundColor = UIColor(named: "AppCellGray")
            self.buttonMore.setTitle("Pending", for: .normal)
        }
    }

    @IBAction func actionOnRiseIssue(_ sender: Any) {
        if let  aIssuesListViewController = IssuesListViewController.getController(story: "Order")  as? IssuesListViewController {
            aIssuesListViewController.productId = aMyOrders.fld_order_id
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
