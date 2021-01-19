//
//  ForgetPasswordViewModel.swift
//  MyOrder
//
//  Created by sourabh on 09/10/20.
//

import UIKit
typealias ForgetSuccess = (_ value: ForgetPasswordModel?) -> Void

class ForgetPasswordViewModel: NSObject {
  
    func forgetServiceCall(aRegistrationType: UserType,
                                 aMobile:String,
                                 aForgetSuccess:@escaping  ForgetSuccess,
                                 aFailed:@escaping  Failed){
        let jsonRequest = ["flag":"0",
                           "fld_user_phone":aMobile]
        var forgetFor = kManufactureForget
        switch aRegistrationType {
        case .manufacture:
            forgetFor = kManufactureForget
        case .stockist:
            forgetFor = kStockistForget
        case .distributor:
            forgetFor = kDistributorForget
        case .retailer:
            forgetFor = kRetailerForget
        case .agent:
            forgetFor = kManufactureForget
        default:
            forgetFor = kSalesagentForget
        }
        ApiService.shared.callServiceWith(apiName: forgetFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let aForgetModel = ForgetPasswordModel(fromDictionary: result ?? [:])
                aForgetSuccess(aForgetModel)
            }else {
                aFailed(error)
            }
        }
    }
}
