//
//  CheckoutViewController.swift
//  MyOrder
//
//  Created by sourabh on 29/10/20.
//

import UIKit

class CheckOutCell: UITableViewCell {
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelItem: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    func setCellData(aCartReviewList: CartReviewList, isReedem: Bool) {
        self.labelQty.text = aCartReviewList.fld_product_qty.description
        self.labelItem.text = aCartReviewList.fld_product_name
        self.labelPrice.text = isReedem == false ? aCartReviewList.fld_spcl_price.description : aCartReviewList.fld_product_points.description
    }
}
class CheckoutViewController: BaseViewController {
    
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var labelAddressTitle: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var tableViewItems: UITableView!
    @IBOutlet weak var constraintTableHeight: NSLayoutConstraint!
    @IBOutlet weak var labelTotalQty: UILabel!
    @IBOutlet weak var labelTotalAmount: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var labelNetAmount: UILabel!
    @IBOutlet weak var viewSuccess: UIView!
    
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTotalAmountTitle: UILabel!
    @IBOutlet weak var labelNetAmountTitle: UILabel!
    @IBOutlet weak var labelDiscountTitle: UILabel!
    @IBOutlet weak var redeemHeight: NSLayoutConstraint!
    @IBOutlet weak var viewRedeem: UIView!
    @IBOutlet weak var labelRedeemPoints: UILabel!
    
    var aCheckoutViewModel = CheckoutViewModel()
    var aCheckoutModel = CheckoutModel()
    var aAddressListModel = AddressListModel()
    var aAddressListViewModel = AddressListViewModel()
    var aCouponModel = CouponModel()
    var aProfileViewModel = ProfileViewModel()
    var isRedeemView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.updateUI()
        self.viewSuccess.isHidden = true
        if isRedeemView == true {
            self.labelPrice.text = "Points"
            self.labelTotalAmountTitle.text = "Total Points"
            self.labelNetAmountTitle.text = "Points redeemed"
            self.labelDiscountTitle.text = " "
            self.labelDiscount.text = " "
            self.viewRedeem.layer.borderWidth = 1.0
            self.viewRedeem.layer.borderColor = UIColor.lightGray.cgColor
            self.redeemHeight.constant = 40.0
        }else {
            self.redeemHeight.constant = 0.0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getAddressServiceCall()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnRedeemPoints(_ sender: Any) {
    }
    @IBAction func actionOnChange(_ sender: Any) {
        if let aAddressListViewController = AddressListViewController.getController(story: "Profile")  as? AddressListViewController {
            self.navigationController?.pushViewController(aAddressListViewController, animated: true)
        }
    }
    @IBAction func actionOnContinueShoping(_ sender: Any) {
        self.addSideMenu()
    }
    @IBAction func actionOnPlaceOrder(_ sender: Any) {
        if self.isRedeemView == true {
            let points = Int(self.labelRedeemPoints.text!) ?? 0
            let total = aCheckoutModel.cart_total - aCheckoutModel.aCouponModel.discount_amount
            if total <= points {
                self.placeOrder()
            }else {
                self.showAlartWith(message: "Insufficient points")
            }
        }else {
            self.placeOrder()
        }
    }
}
extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = aCheckoutModel.aCartReviewList.count
        if count > 0 {
            self.constraintTableHeight.constant = CGFloat(35 + count * 60)
        }
        return count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutCell") as! CheckOutCell
        cell.setCellData(aCartReviewList: aCheckoutModel.aCartReviewList[indexPath.row], isReedem: self.isRedeemView)
        cell.selectionStyle = .none
        return cell
    }
}

extension CheckoutViewController {
    func getCartReview(){
        if self.isRedeemView == true {
            self.showActivity()
            self.aCheckoutViewModel.getCartPointsServiceCall{ (model) in
                self.hideActivity()
                self.labelRedeemPoints.text = model
                self.getCart()
            }  aFailed: { (error) in
                self.hideActivity()
                self.getCart()
            }
        }else {
            getCart()
        }
    }
    
    func getCart(){
        self.showActivity()
        self.aCheckoutViewModel.getCartReviewServiceCall(isRedeem: self.isRedeemView){ (model) in
            self.hideActivity()
            self.aCheckoutModel = model
            self.aCheckoutModel.aCouponModel = self.aCouponModel
            self.updateUI()
        }  aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    
    func getAddressServiceCall() {
        self.showActivity()
        self.aAddressListViewModel.aGetAddressListServiceCall { (model) in
            self.hideActivity()
            var flag = true
            if model.count > 0 {
                model.forEach { object in
                    if object.fld_address_default == true {
                        flag = false
                        self.aAddressListModel = object
                    }
                }
            }
            if flag == true {
                self.userProfileServiceCall()
            }else {
                self.getCartReview()
            }
        }  aFailed: { (error) in
            self.hideActivity()
            //            self.showAlartWith(message: error!.localizedDescription)
            self.userProfileServiceCall()
        }
    }
    func userProfileServiceCall() {
        self.showActivity()
        self.aProfileViewModel.userProfileServiceCall { (modle) in
            self.hideActivity()
            self.aAddressListModel = AddressListModel(aCompanyInfo: modle.aCompanyInfo)
            self.getCartReview()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func updateUI() {
        self.tableViewItems.separatorColor = UIColor.clear
        self.labelTotalQty.text = aCheckoutModel.total_qty.description
        
        
        if self.isRedeemView == false {
            self.labelTotalAmount.text = "₹ " + String(format: "%.2f",Double(aCheckoutModel.cart_total))
            self.labelDiscount.text = "₹ " + String(format: "%.2f", Double(aCheckoutModel.aCouponModel.discount_amount))
            self.labelNetAmount.text = "₹ " + String(format: "%.2f", Double(aCheckoutModel.cart_total - aCheckoutModel.aCouponModel.discount_amount))
        }else {
            self.labelTotalAmount.text =  String(format: "%.2f",Double(aCheckoutModel.cart_total))
            self.labelDiscount.text =  " "
            self.labelNetAmount.text = String(format: "%.2f", Double(aCheckoutModel.cart_total - aCheckoutModel.aCouponModel.discount_amount))
        }
        
        
        
        
        self.tableViewItems.reloadData()
        self.labelAddressTitle.text = aAddressListModel.fld_user_name
        self.labelAddress.text = aAddressListModel.fld_user_address + ", " +
            aAddressListModel.fld_user_country + ", " +
            aAddressListModel.fld_user_state_name + ", " +
            aAddressListModel.fld_user_city_name + ", " +
            aAddressListModel.fld_user_area_name + ", " +
            aAddressListModel.fld_user_pincode
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewAddress.shadowWithRadius()
        }
    }
    
    func placeOrder(){
        self.showActivity()
        self.aCheckoutViewModel.placeOrderCODServiceCall(isRedeem: self.isRedeemView, afld_shipping_id: aAddressListModel.fld_address_id,
                                                         afld_coupon_code: aCheckoutModel.aCouponModel.coupon_code,
                                                         afld_shipping_charges: 0,
                                                         afld_grand_total: aCheckoutModel.cart_total - aCheckoutModel.aCouponModel.discount_amount,
                                                         afld_discount_amount: aCheckoutModel.aCouponModel.discount_amount,
                                                         afld_coupon_percent: aCheckoutModel.aCouponModel.discount_percent) { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                self.viewSuccess.isHidden = false
                self.addLeftBarButton(imageName: "nil")
                
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
            self.getCartReview()
        }
    }
}
