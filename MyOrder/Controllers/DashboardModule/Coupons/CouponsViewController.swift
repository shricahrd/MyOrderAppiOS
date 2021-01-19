//
//  CouponsViewController.swift
//  MyOrder
//
//  Created by sourabh on 06/11/20.
//

import UIKit

class CouponsCell: UITableViewCell {
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelDiscound: UILabel!
    @IBOutlet weak var labelDiscountitem: UILabel!
    @IBOutlet weak var labelDiscription: UILabel!
    @IBOutlet weak var buttonApply: BorderButton!
    
    func setCellData(aCouponsModel: CouponsModel) {
        self.viewBorder.shadowWithRadius()
        self.labelCode.text = aCouponsModel.fld_coupon_code
        self.labelDiscound.text = aCouponsModel.fld_coupon_attr_name
        self.labelDiscountitem.text = aCouponsModel.fld_coupon_name
        self.labelDiscription.text = aCouponsModel.fld_description
    }
}

class CouponsViewController: BaseViewController {
    @IBOutlet weak var tableViewCoupon: UITableView!
    var aCouponsViewModel = CouponsViewModel()
    var aCouponsModels: [CouponsModel] = []
    var aCode : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.getCoupons()
        self.tableViewCoupon.separatorColor = .clear
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension  CouponsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        aCouponsModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponsCell") as! CouponsCell
        cell.selectionStyle = .none
        cell.setCellData(aCouponsModel: self.aCouponsModels[indexPath.row])
        cell.buttonApply.tag = indexPath.row
        if cell.labelCode.text == self.aCode{
            cell.buttonApply.setTitle("Remove", for: .normal)
        }else {
            cell.buttonApply.setTitle("Apply", for: .normal)
        }
        cell.buttonApply.addTarget(self, action: #selector(self.actionOnApply), for: UIControl.Event.touchUpInside)
        return cell
    }
    
    @objc func actionOnApply(sender: UIButton) {
        if sender.title(for: .normal) == "Remove" {
            self.aCode = ""
            self.tableViewCoupon.reloadData()
        } else {
            for controller in self.navigationController!.viewControllers {
                if let vc = controller as? CartViewController {
                    vc.aCouponCode = self.aCouponsModels[sender.tag].fld_coupon_code
                    vc.autoApplyCouponCode = true
                    break
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
//        self.wishListUpdateServiceCall(index: sender.tag)
    }
    
}
extension  CouponsViewController {
    func getCoupons(){
        self.showActivity()
        self.aCouponsViewModel.getCopons { (copons) in
            self.hideActivity()
            self.aCouponsModels = copons
            self.tableViewCoupon.reloadData()
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
//
