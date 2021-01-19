//
//  RedeemOrderViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit

typealias RedeemOrderModelSuccess = (_ model: RedeemOrderModel) -> Void

class RedeemOrderViewModel: NSObject {
    func aGetRedeemListServiceCall(afld_page_no: Int,
                                   aRedeemOrderModelSuccess:@escaping  RedeemOrderModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_page_no":afld_page_no,
                       "fld_order_type": 0,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kRewardOrderList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["order_data"] as? [[String: Any]] ?? []
                var aRedeemOrders: [RedeemOrders] = []
                object.forEach { order in
                    let products = order["ordered_products"] as? [[String: Any]] ?? []
                    var aRedeemOrderProducts: [RedeemOrderProducts] = []
                    products.forEach { prod in
                        aRedeemOrderProducts.append(RedeemOrderProducts(fromDictionary: prod))
                    }
                    aRedeemOrders.append(RedeemOrders(fromDictionary: order, aRedeemOrderProducts: aRedeemOrderProducts))
                }
                let myorders = RedeemOrderModel(fromDictionary: result!, aRedeemOrders: aRedeemOrders)
                aRedeemOrderModelSuccess(myorders)
            }else {
                aFailed(error)
            }
        }
    }
}
