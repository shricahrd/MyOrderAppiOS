//
//  OrderCancelViewModel.swift
//  MyOrder
//
//  Created by sourabh on 07/11/20.
//

import UIKit
typealias CancelReasonSuccess = (_ model: [CancelReason]) -> Void
class OrderCancelViewModel: NSObject {
    func getCancelReasonServiceCall(fld_product_id: String,
                              aCancelReasonSuccess: @escaping CancelReasonSuccess,
                              aFailed: @escaping Failed) {
        let jsonReq = ["fld_reason_type": 0,
                       "fld_product_id": fld_product_id,
                       ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCancelReason, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["reason_data"] as? [[String: Any]] ?? []
                var aCancelReason: [CancelReason] = []
                object.forEach { invoice in
                    aCancelReason.append(CancelReason(fromDictionary: invoice))
                }
                aCancelReasonSuccess(aCancelReason)
            }else {
                aFailed(error)
            }
        }
    }
    func cancelServiceCall(fld_product_id: String,
                           fld_reason_id: Int,
                           comment: String,
                           aAddDefultAddressSuccess: @escaping AddDefultAddressSuccess,
                           aFailed: @escaping Failed) {
        let jsonReq = ["fld_reason_type": 0,
                       "fld_order_id": fld_product_id,
                       "fld_reason_id": fld_reason_id,
                       "fld_comments": comment] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCancelOrder, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddDefultAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
}
