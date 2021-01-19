//
//  CartViewCells.swift
//  MyOrder
//
//  Created by sourabh on 29/10/20.
//

import UIKit
class CartBottomCell: UITableViewCell {
    typealias CouponApply = (_ code: String) -> Void
    typealias CouponRemove = () -> Void

    @IBOutlet weak var labelTotalQty: UILabel!
    @IBOutlet weak var labelTotalAmount: UILabel!
    @IBOutlet weak var labelDiscount: UILabel!
    @IBOutlet weak var labelNetAmount: UILabel!
    @IBOutlet weak var textFieldCoupenCode: UITextField!
    @IBOutlet weak var buttonApply: BorderButton!
    @IBOutlet weak var buttonCheckOut: BorderButton!
    var aCouponApplyComplition : CouponApply? = nil
    var aCouponRemoveComplition : CouponRemove? = nil

    func setCellData(aCartModel: CartModel,aCode: String, aCouponApply:@escaping  CouponApply,  aCouponRemove:@escaping  CouponRemove){
        self.textFieldCoupenCode.text = aCode
        self.aCouponApplyComplition = aCouponApply
        self.aCouponRemoveComplition = aCouponRemove
        self.labelTotalQty.text = aCartModel.total_qty.description
        self.labelTotalAmount.text = "₹ " + String(format: "%.2f",Double(aCartModel.cart_total))
        self.labelDiscount.text = "₹ " + String(format: "%.2f", Double(aCartModel.aCouponModel.discount_amount))
        self.labelNetAmount.text = "₹ " + String(format: "%.2f", Double(aCartModel.cart_total - aCartModel.aCouponModel.discount_amount))
        if aCartModel.aCouponModel.coupon_code != "" {
            self.buttonApply.setTitle("Remove", for: .normal)
        }else {
            self.buttonApply.setTitle("Apply", for: .normal)
        }
        self.buttonApply.addTarget(self, action: #selector(self.actionOnCouponApply), for: UIControl.Event.touchUpInside)
    }
    @objc func actionOnCouponApply(sender: UIButton) {
        if sender.title(for: .normal) == "Remove" {
            aCouponRemoveComplition!()
        }else {
            aCouponApplyComplition!(self.textFieldCoupenCode.text!)
        }
    }
}
class CartColorCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    typealias SizeDelete = (_ index: Int) -> Void
    typealias SizeUpdate = (_ index: Int, _ qty: Int) -> Void

    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var colorViewHeight: NSLayoutConstraint!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var buttonDropDown: UIButton!
    @IBOutlet weak var constraintSizesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewSize: UITableView!
    @IBOutlet weak var viewBorder: UIView!
    var aaColorsizelist = Colorsizelist()
    var sizeDeleteComplition : SizeDelete? = nil
    var sizeUpdateComplition : SizeUpdate? = nil

    func setCellData(aColorsizelist: Colorsizelist, aSizeDelete:@escaping  SizeDelete, aSizeUpdate:@escaping  SizeUpdate){
        aaColorsizelist = aColorsizelist
        sizeDeleteComplition = aSizeDelete
        sizeUpdateComplition = aSizeUpdate
        self.labelQty.text = aColorsizelist.color_size_qty.description
        self.labelName.text = aColorsizelist.color_name
        self.tableViewSize.dataSource = self
        self.tableViewSize.delegate = self
        var sizeCount = aaColorsizelist.size_list.count
        if aaColorsizelist.isSizeVisible == false {
            sizeCount = 0
        }
        self.constraintSizesTableHeight.constant = CGFloat(sizeCount > 0 ?  35 + CGFloat(60 * sizeCount) : 0)
        self.tableViewSize.reloadData()
        var bounds = self.viewBorder.bounds
        bounds.size.height = self.constraintSizesTableHeight.constant + 70
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.viewBorder.shadowWithRadius(aBounds: bounds)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sizeCount = aaColorsizelist.size_list.count
        if aaColorsizelist.isSizeVisible == false {
            sizeCount = 0
        }
        return sizeCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSizeCell") as! ProductSizeCell
        cell.setUpCellData(aSizes: aaColorsizelist.size_list[indexPath.row])
        cell.buttonAddRemove?.tag = indexPath.row
        cell.buttonAddRemove?.addTarget(self, action: #selector(self.actionOnAddToCart), for: UIControl.Event.touchUpInside)
        cell.buttonUpdate?.tag = indexPath.row
        cell.buttonUpdate?.addTarget(self, action: #selector(self.actionOnUpdateCart), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        cell.layoutIfNeeded()
        return cell
    }
    @objc func actionOnAddToCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        sizeDeleteComplition!(indexPath.row)
    }
    @objc func actionOnUpdateCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableViewSize.cellForRow(at: indexPath) as! ProductSizeCell
        let qty = Int(cell.textFieldQty.text!) ?? 0
        sizeUpdateComplition!(indexPath.row, qty)
    }
}
class CartViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource  {
    typealias ColorSelect = (_ index: Int) -> Void
    typealias ColorSizeDelete = (_ colorIndex: Int, _ sizeIndex: Int) -> Void
    typealias ColorSizeUpdate = (_ colorIndex: Int, _ sizeIndex: Int, _ qty: Int) -> Void
    
    typealias AdditionalDelete = (_ sizeIndex: Int) -> Void
    typealias AdditionalUpdate = (_ sizeIndex: Int, _ qty: Int) -> Void

    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelSku: UILabel!
    @IBOutlet weak var labelSuplier: UILabel!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var tableViewColor: UITableView!
    @IBOutlet weak var tableViewSizeColor: UITableView!
    @IBOutlet weak var constraintColorHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintSizeColorHeight: NSLayoutConstraint!
    @IBOutlet weak var buttonCancelOrder: UIButton!
    @IBOutlet weak var textFieldQty: UITextField!
    @IBOutlet weak var buttonUpdateQty: UIButton!
    
    var colorSelectComplition : ColorSelect? = nil
    var colorSizeDeleteComplition : ColorSizeDelete? = nil
    var colorSizeUpdateComplition : ColorSizeUpdate? = nil
    var aAdditionalDeleteComplition : AdditionalDelete? = nil
    var aAdditionalUpdateComplition : AdditionalUpdate? = nil
    var aaCartList = CartList()
    func setCellData(aCartList: CartList,
                     aColorSelect:@escaping  ColorSelect,
                     aColorSizeDelete:@escaping  ColorSizeDelete,
                     aColorSizeUpdate:@escaping  ColorSizeUpdate,
                     aAdditionalDelete:@escaping  AdditionalDelete,
                     aAdditionalUpdate:@escaping  AdditionalUpdate) {
        aaCartList = aCartList
        self.colorSelectComplition = aColorSelect
        self.colorSizeDeleteComplition = aColorSizeDelete
        self.colorSizeUpdateComplition = aColorSizeUpdate
        self.aAdditionalDeleteComplition = aAdditionalDelete
        self.aAdditionalUpdateComplition = aAdditionalUpdate
        let url = URL(string: aCartList.default_image)
        self.imageViewProduct?.kf.indicatorType = .activity
        self.imageViewProduct?.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderCell"))
        self.labelName.text = aCartList.fld_product_name
        self.labelSku?.text = aCartList.fld_product_sku
        self.labelSuplier.text = "Suplier: " + aCartList.fld_supplier_name
        self.tableViewColor.dataSource = self
        self.tableViewColor.delegate = self
        self.constraintColorHeight.constant = 0
        self.constraintSizeColorHeight?.constant = 0
        self.tableViewSizeColor?.dataSource = self
        self.tableViewSizeColor?.delegate = self
        self.tableViewSizeColor?.separatorColor = UIColor.clear
       
        self.textFieldQty?.isHidden = false
        self.buttonUpdateQty?.isHidden = false
        self.textFieldQty?.text = aaCartList.fld_product_qty
        
        if aaCartList.colorsizelist.count > 0 {
            var cellHeight = aaCartList.colorsizelist.count * (70 + 20)
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
                self.textFieldQty?.isHidden = true
                self.buttonUpdateQty?.isHidden = true
            }
            self.constraintColorHeight.constant = CGFloat(cellHeight)
            self.tableViewColor.reloadData()
            self.tableViewColor.separatorColor = UIColor.clear
        }else {
            if aaCartList.aAdditionalSize.count > 0 {
                var cellHeight = 20 + 20
                self.aaCartList.aAdditionalSize.forEach { additionalSize in
                    cellHeight = cellHeight + 60
                }
                self.textFieldQty.isHidden = true
                self.buttonUpdateQty.isHidden = true
                self.constraintSizeColorHeight?.constant = CGFloat(cellHeight)
            }else if aaCartList.aAdditionalColor.count > 0  {
                var cellHeight = 20 + 20
                self.aaCartList.aAdditionalColor.forEach { AdditionalColor in
                    cellHeight = cellHeight + 60
                }
                self.textFieldQty.isHidden = true
                self.buttonUpdateQty.isHidden = true
                self.constraintSizeColorHeight?.constant = CGFloat(cellHeight)
            }
            self.tableViewSizeColor?.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewSizeColor {
            if aaCartList.aAdditionalSize.count > 0 || aaCartList.aAdditionalColor.count > 0 {
                return 1
            }
            else {
                return 0
            }
        }else {
            return aaCartList.colorsizelist.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewSizeColor {
            return 60
        }else{
            var cellHeight = aaCartList.colorsizelist.count * (70 + 20)
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
            return CGFloat(cellHeight)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewSizeColor {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductSizeCell") as! ProductSizeCell
            if aaCartList.aAdditionalSize.count > 0 {
                cell.setUpCellData(aAdditionalSize: self.aaCartList.aAdditionalSize[indexPath.row])
            }else if aaCartList.aAdditionalColor.count > 0 {
                cell.setUpCellData(aAdditionalColor: self.aaCartList.aAdditionalColor[indexPath.row])
            }
          cell.buttonAddRemove?.tag = indexPath.row
          cell.buttonAddRemove?.addTarget(self, action: #selector(self.actionOnAddToCart), for: UIControl.Event.touchUpInside)
          cell.buttonUpdate?.tag = indexPath.row
          cell.buttonUpdate?.addTarget(self, action: #selector(self.actionOnUpdateCart), for: UIControl.Event.touchUpInside)
            cell.selectionStyle = .none
            cell.layoutIfNeeded()
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartColorCell") as! CartColorCell
            cell.setCellData(aColorsizelist: aaCartList.colorsizelist[indexPath.row]) { (sizeIndex) in
                self.colorSizeDeleteComplition!(indexPath.row,sizeIndex)
            } aSizeUpdate: { (sizeIndex, qty) in
                self.colorSizeUpdateComplition!(indexPath.row,sizeIndex, qty)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    @objc func actionOnAddToCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.aAdditionalDeleteComplition!(indexPath.row)
    }
    @objc func actionOnUpdateCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = self.tableViewSizeColor.cellForRow(at: indexPath) as! ProductSizeCell
        let qty = Int(cell.textFieldQty.text!) ?? 0
        self.aAdditionalUpdateComplition!(indexPath.row, qty)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewColor {
            self.colorSelectComplition!(indexPath.row)
        }
    }
}
