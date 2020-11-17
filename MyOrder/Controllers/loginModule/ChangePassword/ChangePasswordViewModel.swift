//
//  ChangePasswordViewModel.swift
//  MyOrder
//
//  Created by gwl on 10/10/20.
//

import UIKit
class ChangePasswordViewModel : NSObject {
    func resetServiceCall(aRegistrationType: UserType,
                          aPassword:String,
                          afld_user_id: Int,
                          aPinModelSuccess:@escaping  PinModelSuccess,
                          aFailed:@escaping  Failed){
        
        let jsonRequest = ["fld_user_id":afld_user_id,
                           "fld_user_password":aPassword] as [String : Any]
        var forgetFor = kManufactureForgetReset
        switch aRegistrationType {
        case .manufacture:
            forgetFor = kManufactureForgetReset
        case .stockist:
            forgetFor = kStockistForgetReset
        case .distributor:
            forgetFor = kDistributorForgetReset
        case .retailer:
            forgetFor = kRetailerForgetReset
        case .agent:
            forgetFor = kManufactureForgetReset
        default:
            forgetFor = kSalesagentForgetReset
        }
        ApiService.shared.callServiceWith(apiName: forgetFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
//                let aForgetModel = ForgetPasswordModel(fromDictionary: result ?? [:])
//                aForgetSuccess(aForgetModel)
            }else {
                aFailed(error)
            }
        }
    }
}
