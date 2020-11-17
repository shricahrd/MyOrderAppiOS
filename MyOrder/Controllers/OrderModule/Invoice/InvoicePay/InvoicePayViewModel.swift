//
//  InvoicePayViewModel.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit

class InvoicePayViewModel: NSObject {
    func submitInvoiceServiceCall(aPayment_mode: String,
                                  aReceipt_no: String,
                                  aAmt: String,
                                  aPay_date: String,
                                  aNarration: String,
                                  aReceipt_image: UIImage,
                              aAddDefultAddressSuccess: @escaping AddDefultAddressSuccess,
                              aFailed: @escaping Failed) {
        let jsonReq = ["payment_mode": aPayment_mode,
                       "receipt_no": aReceipt_no,
                       "amt": aAmt,
                       "pay_date": aPay_date,
                       "narration": aNarration,
                       "fld_user_id": UserModel.shared.fld_user_id,
                       "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        let imgData = aReceipt_image.jpegData(compressionQuality: 1)
        ApiService.shared.uploadImageServiceCall(image: imgData!, apiName: kOrderInvoicePayment, fileName: "receipt_image", parameter: jsonReq) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddDefultAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
}
