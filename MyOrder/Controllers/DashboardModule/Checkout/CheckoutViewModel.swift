//
//  CheckoutViewModel.swift
//  MyOrder
//
//  Created by gwl on 29/10/20.
//

import UIKit
typealias CheckoutModelSuccess = (_ aCheckoutModel: CheckoutModel) -> Void

class CheckoutViewModel: NSObject {
    func getCartReviewServiceCall(aCheckoutModelSuccess:@escaping  CheckoutModelSuccess,
                                  aFailed:@escaping  Failed){
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kCartReview, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aCartData = result?["cart_data"] as? [[String: Any]] ?? []
                var aCartReviewList: [CartReviewList] = []
                aCartData.forEach { object in
                    aCartReviewList.append(CartReviewList(fromDictionary: object))
                }
                let aCheckoutModel =  CheckoutModel(fromDictionary: result!, aCartReviewList: aCartReviewList)
                aCheckoutModelSuccess(aCheckoutModel)
            }else {
                aFailed(error)
            }
        }
    }
    
    func placeOrderCODServiceCall(afld_shipping_id: Int,
                                  afld_coupon_code: String,
                                  afld_shipping_charges: Int,
                                  afld_grand_total: Int,
                                  afld_discount_amount: Int,
                                  afld_coupon_percent: Int,
                                  aAddAddressSuccess:@escaping  AddAddressSuccess,
                                  aFailed:@escaping  Failed){
        
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "fld_shipping_id": afld_shipping_id ,
                        "fld_purchase_type":2,
                        "fld_coupon_code":afld_coupon_code,
                        "fld_txn_id":"",
                        "fld_txn_status":"",
                        "fld_shipping_charges":afld_shipping_charges,
                        "fld_payment_mode":0,
                        "fld_grand_total":afld_grand_total,
                        "fld_wallet_amount":0,
                        "fld_coupon_percent":afld_coupon_percent,
                        "fld_discount_amount":afld_discount_amount,
                        "panel_type":UserModel.shared.aSelectedUserType.rawValue,
                        "fld_tax":0] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kSaveOrder, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
}
