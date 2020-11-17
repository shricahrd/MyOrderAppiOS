//
//  OrderListViewModel.swift
//  MyOrder
//
//  Created by gwl on 29/10/20.
//

import Foundation


typealias OrderListModelSuccess = (_ model: OrderListModel) -> Void

class OrderListViewModel: NSObject {
    func aGetOrdersListServiceCall(afld_page_no: Int,
                                    aOrderListModelSuccess:@escaping  OrderListModelSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_order_type": 0,
                       "fld_page_no":afld_page_no,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kOrderList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["order_data"] as? [[String: Any]] ?? []
                var aMyOrders: [MyOrders] = []
                object.forEach { order in
                    let aCartData = order["ordered_products"] as? [[String: Any]] ?? []
                    var aCartList: [CartList] = []
                    aCartData.forEach { aColorSizesList in
                        let acolorsizes = aColorSizesList["color_size_list"] as? [[String: Any]] ?? []
                        var aColorsizelist: [Colorsizelist] = []
                        acolorsizes.forEach { colors in
                            let size_list = colors["size_list"] as? [[String: Any]] ?? []
                            var aSizeList: [Sizelist] = []
                            size_list.forEach { aSizes in
                                aSizeList.append(Sizelist(fromDictionary: aSizes))
                            }
                            aColorsizelist.append(Colorsizelist(fromDictionary: colors, sizes: aSizeList))
                        }
                        aCartList.append(CartList(fromDictionary: aColorSizesList, aColorsizelist: aColorsizelist))
                    }
                    aMyOrders.append(MyOrders(fromDictionary: order, aCartLists: aCartList))
                }
                let myorders = OrderListModel(fromDictionary: result!, aMyOrders: aMyOrders)
                aOrderListModelSuccess(myorders)
            }else {
                aFailed(error)
            }
        }
    }
}
