//
//  OrderCancelViewController.swift
//  MyOrder
//
//  Created by sourabh on 07/11/20.
//

import UIKit

class OrderCancelViewController: BaseViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSuplierName: UILabel!
    @IBOutlet weak var textFieldReason: UITextField!
    @IBOutlet weak var textViewComment: UITextView!
    var aCancelReason: [CancelReason] = []
    var aOrderCancelViewModel = OrderCancelViewModel()
    var aCartList = CartList()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTitleImage()
        self.addLeftBarButton(imageName: "back")
        self.getCancelReasons()
        self.labelTitle.text = aCartList.fld_product_name
        self.labelSuplierName.text = "Suplier: " + aCartList.fld_supplier_name
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addRightBarButton()
    }
    override func actionOnLeftIcon() {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionOnReason(_ sender: Any) {
        let cancelReason = aCancelReason.map { $0.fld_reason }
        GWLListPicker.shared.showSingleSelect(title: "Please select cancel reason", tableArray: cancelReason, selected: [self.textFieldReason.text!] ,backgroundColor: .white, highLightColor: UIColor(named: "AppLightBlue")!){ (value) in
            self.textFieldReason.text = value?.first
        }
    }
    @IBAction func actionOnSubmit(_ sender: Any) {
        if textFieldReason.text?.isEmpty == true {
            self.showAlartWith(message: SelectReason)
        }else {
            self.cancelOrder()
        }
    }
}
extension OrderCancelViewController {
    func getCancelReasons() {
        self.showActivity()
        self.aOrderCancelViewModel.getCancelReasonServiceCall(fld_product_id: aCartList.fld_product_id) { (models) in
            self.hideActivity()
            self.aCancelReason = models
        }   aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
    func cancelOrder() {
        self.showActivity()
        var reasonId = 0
        if let rsn = self.aCancelReason.first(where: {$0.fld_reason == self.textFieldReason.text ?? ""}) {
            reasonId = rsn.fld_reason_id
        }
        self.aOrderCancelViewModel.cancelServiceCall(fld_product_id: aCartList.fld_product_id,
                                                     fld_reason_id: reasonId,
                                                     comment: self.textViewComment.text ?? "") { (msg) in
            self.hideActivity()
            self.showAlartWith(message: msg) { (done) in
                self.navigationController?.popViewController(animated: true)
            }
        } aFailed: { (error) in
            self.hideActivity()
            self.showAlartWith(message: error!.localizedDescription)
        }
    }
}
