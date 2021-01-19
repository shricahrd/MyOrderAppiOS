//
//  RewardCartViewController.swift
//  MyOrder
//
//  Created by MAC-51 on 21/12/20.
//

import UIKit

class RewardCartCell : UITableViewCell {
    typealias updateQty = (_ aRewardCartList: RewardCartList, _ qty: String) -> Void
    @IBOutlet weak var imageVIewProduct: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var textFieldQty: UITextField!
    @IBOutlet weak var buttonSync: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    
    var aUpdateQtyComplition : updateQty? = nil
    var aaRewardCartList: RewardCartList!
    func setUpCellData(aRewardCartList: RewardCartList, aUpdateQty:@escaping  updateQty) {
        self.aUpdateQtyComplition = aUpdateQty
        aaRewardCartList = aRewardCartList
        let url = URL(string: aRewardCartList.default_image)
        self.imageVIewProduct.kf.indicatorType = .activity
        self.imageVIewProduct.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSquare"))
        self.labelName.text = aRewardCartList.fld_product_name
        self.labelPoints.text = "Points: " + aRewardCartList.fld_product_points.description
        self.textFieldQty.text = aRewardCartList.fld_product_qty.description
        self.buttonSync.addTarget(self, action: #selector(self.actionOnCouponApply), for: UIControl.Event.touchUpInside)
    }
    @objc func actionOnCouponApply(sender: UIButton) {
        aUpdateQtyComplition!(aaRewardCartList, textFieldQty.text!)
    }
}
class RewardCartViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var labelQty: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var viewEmptyData: UIView!
    var showEmpty = false
    var aRewardCartModel = RewardCartModel()
    var aRewardCartViewModel = RewardCartViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.addRightBarButton()
        self.serviceCall()
        self.aSearchProductViewController.aSearchComplition = { object in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.goToSearchResult(text: object)
            }
        }
    }
    @IBAction func actionOnCheckout(_ sender: Any) {
        if let aCheckoutViewController = CheckoutViewController.getController(story: "Dashboard")  as? CheckoutViewController {
            aCheckoutViewController.isRedeemView = true
            self.navigationController?.pushViewController(aCheckoutViewController, animated: true)
        }
    }
    @IBAction func actionOnShopNow(_ sender: Any) {
        self.addSideMenu()
    }
}
extension RewardCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.aRewardCartModel.aRewardCartList.count
        if showEmpty == true {
            self.viewEmptyData.isHidden =  count > 0 ? true :false
        }else {
            self.viewEmptyData.isHidden = true
        }
       return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCartCell") as! RewardCartCell
        cell.setUpCellData(aRewardCartList: self.aRewardCartModel.aRewardCartList[indexPath.row]) { (obj, qty) in
            self.updateServiceCall(aRewardCartList: obj, qty: qty)
        }
        cell.buttonDelete.tag = indexPath.row
        cell.buttonDelete.addTarget(self, action: #selector(self.actionOnDelete), for: UIControl.Event.touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    @objc func actionOnDelete(sender: UIButton) {
        self.deleteServiceCall(aRewardCartList: self.aRewardCartModel.aRewardCartList[sender.tag])
        
    }
}
extension RewardCartViewController: UITextFieldDelegate {
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
extension RewardCartViewController {
    func serviceCall(){
        self.showActivity()
        self.aRewardCartViewModel.aGetRewardCartListServiceCall() { (model) in
            self.hideActivity()
            self.showEmpty = true
            self.aRewardCartModel = model
            self.labelQty.text = model.total_qty.description
            self.labelPoints.text = model.cart_total.description
            self.tableView.reloadData()
        }  aFailed: { (error) in
            self.hideActivity()
            self.showEmpty = true
            self.tableView.reloadData()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func updateServiceCall(aRewardCartList: RewardCartList, qty: String){
        let qtsy = Int(qty) ?? 0
        if qtsy == 0 {
            self.showAlartWith(message: "Qty can't be zero." )
        }else {
            self.showActivity()
            self.aRewardCartViewModel.aUpdateCartQtyServiceCall(fld_product_id: aRewardCartList.fld_product_id,
                                                                fld_product_points: aRewardCartList.fld_product_points,
                                                                fld_product_qty: qty) {
                self.hideActivity()
                self.serviceCall()
            } aFailed: { (error) in
                self.hideActivity()
                //self.showAlartWith(message: error!.localizedDescription)
            }
        }
    }
    func deleteServiceCall(aRewardCartList: RewardCartList){
        self.showActivity()
        self.aRewardCartViewModel.aDeleteCartItemServiceCall(fld_product_id: aRewardCartList.fld_product_id) {
            self.hideActivity()
            self.serviceCall()
        } aFailed: { (error) in
            self.hideActivity()
            //self.showAlartWith(message: error!.localizedDescription)
        }
    }
}

