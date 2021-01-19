//
//  RewardOrderDetailsViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 22/12/20.
//

import UIKit

class RewardOrderDetailsCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    
    func setCellData(aRedeemOrderProducts: RedeemOrderProducts) {
        labelTitle.text = aRedeemOrderProducts.fld_product_name
        labelQty.text = aRedeemOrderProducts.fld_order_qty.description
        labelPoints.text = aRedeemOrderProducts.fld_product_points.description
        
    }
}

class RewardOrderDetailsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelOrderNo: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelSubTotal: UILabel!
    @IBOutlet weak var labelRedeemPoint: UILabel!
    @IBOutlet weak var labelGrandTotal: UILabel!
    
    var aRedeemOrders = RedeemOrders()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.updatelabels()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    func updatelabels() {
        labelOrderNo.text = "Order No." + aRedeemOrders.fld_order_no
        labelDate.text = aRedeemOrders.fld_order_date.orderListDate()
        labelAddress.text = aRedeemOrders.fld_order_shipping_address + ", " +
            aRedeemOrders.fld_order_shipping_state_name + ", " +
            aRedeemOrders.fld_order_shipping_city_name + ", " +
            aRedeemOrders.fld_order_shipping_area_name + ", " +
            aRedeemOrders.fld_order_shipping_zip
        labelSubTotal.text = aRedeemOrders.fld_order_total_amt.description
        labelRedeemPoint.text = aRedeemOrders.fld_order_total_amt.description
        labelGrandTotal.text = aRedeemOrders.fld_order_total_amt.description
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension RewardOrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aRedeemOrders.aRedeemOrderProducts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardOrderDetailsCell") as! RewardOrderDetailsCell
        cell.setCellData(aRedeemOrderProducts: aRedeemOrders.aRedeemOrderProducts[indexPath.row])
        return cell
    }
}
