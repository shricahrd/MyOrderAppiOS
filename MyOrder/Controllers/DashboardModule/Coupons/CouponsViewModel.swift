//
//  CouponsViewModel.swift
//  MyOrder
//
//  Created by gwl on 06/11/20.
//

import Foundation

typealias CouponsModelSuccess = (_ model: [CouponsModel]) -> Void

class CouponsViewModel: NSObject {
    func getCopons(aCouponsModelSuccess:@escaping  CouponsModelSuccess,
                  aFailed:@escaping  Failed){
        ApiService.shared.callServiceWith(apiName: kCoupons, parameter: [:], methods:  .post) { (result, error) in
            if error == nil {
                let aObjects = result?["coupon_return"] as? [[String: Any]] ?? []
                var aCouponsModel: [CouponsModel] = []
                aObjects.forEach { object in
                    aCouponsModel.append(CouponsModel(fromDictionary: object))
                }
                aCouponsModelSuccess(aCouponsModel)
            }else {
                aFailed(error)
            }
        }
    }
}
