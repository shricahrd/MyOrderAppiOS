//
//  CartViewModel.swift
//  MyOrder
//
//  Created by sourabh on 19/10/20.
//

import UIKit
typealias CartModelSuccess = (_ model: CartModel) -> Void
typealias CouponSuccess = (_ model: CouponModel) -> Void

class CartViewModel: NSObject {
    func addToCartServiceCall(aAddCardModel: [AddCart],
                              aAddAddressSuccess:@escaping  AddAddressSuccess,
                              aFailed:@escaping  Failed){
        var jsonReq =  ["fld_action_type":0,
                        "fld_user_id":UserModel.shared.fld_user_id,
                        "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        var dataArray: [[String: Any]] = []
        aAddCardModel.forEach { model in
            dataArray.append(model.toDictionary())
        }
        jsonReq["data"] = dataArray
        ApiService.shared.callServiceWith(apiName: kCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                UserModel.shared.aCartTotalCount =  result?["cart_total_count"] as? Int ?? 0
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    func cartListServiceCall(aCartModelSuccess:@escaping  CartModelSuccess,
                             aFailed:@escaping  Failed){
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCartList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aCartData = result?["cart_data"] as? [[String: Any]] ?? []
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
                    let aColorOnly = aColorSizesList["colors_list"] as? [[String: Any]] ?? []
                    var aAdditionalColorlist: [AdditionalColor] = []
                    aColorOnly.forEach { colors in
                        aAdditionalColorlist.append(AdditionalColor(fromDictionary: colors))
                    }
                    let aSizeOnly = aColorSizesList["sizes_list"] as? [[String: Any]] ?? []
                    var aAdditionalSizelist: [AdditionalSize] = []
                    aSizeOnly.forEach { size in
                        aAdditionalSizelist.append(AdditionalSize(fromDictionary: size))
                    }
                    aCartList.append( CartList(fromDictionary: aColorSizesList,
                                               aColorsizelist: aColorsizelist,
                                               aAdditionalColor: aAdditionalColorlist,
                                               aAdditionalSize: aAdditionalSizelist))
                }
                aCartModelSuccess(CartModel(fromDictionary: result!, aCartList: aCartList))
            }else {
                aFailed(error)
            }
        }
    }
    
    func deleteCartServiceCall( aProductId: String,
                                aAddAddressSuccess:@escaping  AddAddressSuccess,
                                aFailed:@escaping  Failed) {
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "fld_action_type":4,
                        "fld_product_id":aProductId,
                        "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                UserModel.shared.aCartTotalCount =  result?["cart_total_count"] as? Int ?? 0
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    
    func deleteCartElementsServiceCall( aProductId: String,
                                        aColorId: Int,
                                        aSizeId: Int,
                                        aAddAddressSuccess:@escaping  AddAddressSuccess,
                                        aFailed:@escaping  Failed) {
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "fld_action_type":1,
                        "fld_product_id":aProductId,
                        "fld_size_id":aSizeId,
                        "fld_color_id":aColorId,
                        "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                UserModel.shared.aCartTotalCount =  result?["cart_total_count"] as? Int ?? 0
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    func updateCartElementsServiceCall( aProductId: String,
                                        aColorId: Int,
                                        aSizeId: Int,
                                        aQty: Int,
                                        aAddAddressSuccess:@escaping  AddAddressSuccess,
                                        aFailed:@escaping  Failed) {
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "fld_action_type":2,
                        "fld_product_id":aProductId,
                        "fld_size_id":aSizeId,
                        "fld_color_id":aColorId,
                        "fld_product_qty":aQty,
                        "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCartAddUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                UserModel.shared.aCartTotalCount =  result?["cart_total_count"] as? Int ?? 0
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    func getCouponDiscountServiceCall( aCode: String,
                                       aCouponSuccess:@escaping  CouponSuccess,
                                       aFailed:@escaping  Failed) {
        let jsonReq =  ["fld_user_id":UserModel.shared.fld_user_id,
                        "coupon_code":aCode,
        ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kCartCoupon, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                aCouponSuccess(CouponModel(fromDictionary: result!))
            }else {
                aFailed(error)
            }
        }
    }
}
