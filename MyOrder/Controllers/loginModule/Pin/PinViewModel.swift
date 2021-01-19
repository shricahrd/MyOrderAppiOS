//
//  PinViewModel.swift
//  MyOrder
//
//  Created by sourabh on 09/10/20.
//

import Foundation
typealias ResendSuccess = () -> Void
typealias PinModelSuccess = (_ value: PinModel?) -> Void

class PinViewModel: NSObject {
    func resendServiceCall(aRegistrationType: UserType,
                                 aMobile:String,
                                 aResendSuccess:@escaping  ResendSuccess,
                                 aFailed:@escaping  Failed){
        let jsonRequest = ["flag":"1",
                           "fld_user_phone":aMobile]
        var resendFor = kManufactureForgetResend
        switch aRegistrationType {
        case .manufacture:
            resendFor = kManufactureForgetResend
        case .stockist:
            resendFor = kStockistForgetResend
        case .distributor:
            resendFor = kDistributorForgetResend
        case .retailer:
            resendFor = kRetailerForgetResend
        case .agent:
            resendFor = kManufactureForgetResend
        default:
            resendFor = kSalesagentForgetResend
        }
        ApiService.shared.callServiceWith(apiName: resendFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                aResendSuccess()
            }else {
                aFailed(error)
            }
        }
    }
    
    func verifiyServiceCall(aRegistrationType: UserType,
                                 aMobile:String,
                                 aOtp:String,
                                 afld_user_id: Int,
                                 aPinModelSuccess:@escaping  PinModelSuccess,
                                 aFailed:@escaping  Failed){
        let jsonRequest = ["flag":"0",
                           "otp":aOtp,
                           "fld_user_id":afld_user_id,
                           "fld_user_phone":aMobile] as [String : Any]
        var verifyFor = kManufactureForgetVerify
        switch aRegistrationType {
        case .manufacture:
            verifyFor = kManufactureForgetVerify
        case .stockist:
            verifyFor = kStockistForgetVerify
        case .distributor:
            verifyFor = kDistributorForgetVerify
        case .retailer:
            verifyFor = kRetailerForgetVerify
        case .agent:
            verifyFor = kManufactureForgetVerify
        default:
            verifyFor = kSalesagentForgetVerify
        }
        ApiService.shared.callServiceWith(apiName: verifyFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let aPinModel = PinModel(fromDictionary: result?["user_data"] as? [String: Any] ?? [:])
                aPinModelSuccess(aPinModel)
            }else {
                aFailed(error)
            }
        }
    }
}
