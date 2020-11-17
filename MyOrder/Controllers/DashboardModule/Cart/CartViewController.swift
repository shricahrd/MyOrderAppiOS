//
//  CartViewController.swift
//  MyOrder
//
//  Created by gwl on 19/10/20.
//

import UIKit

class CartViewController: BaseViewController {
    @IBOutlet weak var tableViewCart: UITableView!
    
    @IBOutlet weak var viewEmptyData: UIView!
    var aCartViewModel = CartViewModel()
    var aCartModel = CartModel()
    var showEmpty = false
    var shouldShowBack = true
    var aCouponCode : String = ""
    var autoApplyCouponCode : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        if shouldShowBack == true {
            self.addLeftBarButton(imageName: "back")
        }else {
            self.addLeftBarButton()
        }
        self.getCartList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewCart.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.autoApplyCouponCode == true {
            self.autoApplyCouponCode = false
            self.getCouponDiscount(code: self.aCouponCode)
        }
    }
    override func actionOnLeftIcon(){
        if shouldShowBack == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            panel?.openLeft(animated: true)
        }
    }
    @IBAction func actionOnShopNow(_ sender: Any) {
        self.addSideMenu()
    }
    @IBAction func actionOnMoreCoupons(_ sender: Any) {
        if let aCouponsViewController = CouponsViewController.getController(story: "Dashboard")  as? CouponsViewController {
            aCouponsViewController.aCode = self.aCouponCode
            self.navigationController?.pushViewController(aCouponsViewController, animated: true)
        }
    }
}
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = aCartModel.aCartList.count
        if showEmpty == true {
            self.viewEmptyData.isHidden =  count > 0 ? true :false
        }else {
            self.viewEmptyData.isHidden = true
        }
        return count > 0 ? count + 1 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == aCartModel.aCartList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartBottomCell") as! CartBottomCell
            cell.setCellData(aCartModel: self.aCartModel, aCode: self.aCouponCode) { (code) in
                self.aCouponCode = code
                self.couponCodeApply(aCode: code)
            } aCouponRemove: {
                self.aCouponCode = ""
                self.aCartModel.aCouponModel = CouponModel()
                self.tableViewCart.reloadData()
            }
            cell.buttonCheckOut.addTarget(self, action: #selector(self.actionOnCheckOut), for: UIControl.Event.touchUpInside)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartViewCell") as! CartViewCell
            cell.setCellData(aCartList: aCartModel.aCartList[indexPath.row]) { (indexOfColorCell) in
                self.aCartModel.aCartList[indexPath.row].colorsizelist[indexOfColorCell].isSizeVisible = !self.aCartModel.aCartList[indexPath.row].colorsizelist[indexOfColorCell].isSizeVisible
                self.tableViewCart.reloadData()
            } aColorSizeDelete: { (colorIndex, colorSizeIndex) in
                self.removeColorSize(objectIndex: indexPath.row, colorIndex: colorIndex, colorSizeIndex: colorSizeIndex)
            }
            cell.buttonDelete.tag = indexPath.row
            cell.buttonDelete.addTarget(self, action: #selector(self.actionOnDelete), for: UIControl.Event.touchUpInside)
            cell.selectionStyle = .none
            return cell
        }
    }
    @objc func actionOnDelete(sender: UIButton) {
        self.deleteCart(index: sender.tag)
    }
    @objc func actionOnCheckOut(sender: UIButton) {
        if let aCheckoutViewController = CheckoutViewController.getController(story: "Dashboard")  as? CheckoutViewController {
            aCheckoutViewController.aCouponModel = self.aCartModel.aCouponModel
            self.navigationController?.pushViewController(aCheckoutViewController, animated: true)
        }
    }
    func removeColorSize(objectIndex: Int, colorIndex: Int, colorSizeIndex: Int) {
        let object = self.aCartModel.aCartList[objectIndex]
        let color = object.colorsizelist[colorIndex]
        let size = color.size_list[colorSizeIndex]
        self.deleteCartElements(productId: object.fld_product_id, colorId: color.color_id, sizeId: size.size_id)
    }
    func couponCodeApply(aCode: String){
        if aCode.isEmpty == true {
            self.showAlartWith(message: SelectCouponCode)
        }else {
            self.getCouponDiscount(code: aCode)
        }
    }
//
}
extension CartViewController {
    func getCartList() {
        self.showActivity()
        self.aCartViewModel.cartListServiceCall { (model) in
            self.hideActivity()
            self.showEmpty = true
            self.aCartModel = model
            self.tableViewCart.reloadData()
        } aFailed: { (error) in
            self.hideActivity()
            self.aCartModel.aCartList = []
            self.showEmpty = true
            self.tableViewCart.reloadData()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func deleteCart(index: Int) {
        self.showActivity()
        self.aCartViewModel.deleteCartServiceCall(aProductId: self.aCartModel.aCartList[index].fld_product_id) {(msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                self.aCartModel.aCartList.remove(at: index)
                self.tableViewCart.reloadData()
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func deleteCartElements(productId: String, colorId: Int, sizeId: Int) {
        self.showActivity()
        self.aCartViewModel.deleteCartElementsServiceCall(aProductId: productId, aColorId: colorId, aSizeId: sizeId) {(msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.getCartList()
                }
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func getCouponDiscount(code: String){
        self.showActivity()
        self.aCartViewModel.getCouponDiscountServiceCall(aCode: code) { (model)  in
            self.hideActivity()
            self.aCartModel.aCouponModel = model
            self.tableViewCart.reloadData()
        }  aFailed: { (error) in
            self.aCouponCode = ""
            self.tableViewCart.reloadData()
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
