//
//  LoginViewModel.swift
//  MyOrder
//
//  Created by sourabh on 09/10/20.
//

import UIKit

typealias LoginSuccess = (_ value: LoginModel) -> Void

class  LoginViewModel: NSObject {
    
    func loginServiceCall(aRegistrationType: UserType,
                                 aMobile:String,
                                 aPassword:String,
                                 aLoginSuccess:@escaping  LoginSuccess,
                                 aFailed:@escaping  Failed){
        let jsonRequest = ["fld_user_phone":aMobile,
                           "fld_user_password":aPassword,
                           "referal_code":""]
        
        var loginFor = kManufactureLogin
        switch aRegistrationType {
        case .manufacture:
            loginFor = kManufactureLogin
        case .stockist:
            loginFor = kStockistLogin
        case .distributor:
            loginFor = kDistributorLogin
        case .retailer:
            loginFor = kRetailerLogin
        case .agent:
            loginFor = kSalesagentLogin
        default:
            loginFor = kSalesagentLogin
        }
        ApiService.shared.callServiceWith(apiName: loginFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let otp = result?["isOtpVerified"] as? Bool ?? false
                if otp == true {
                    var json = result?["login_data"] as? [String: Any] ?? [:]
                    json["panel_type"] = result?["panel_type"] as? Int ?? 0
                    json["isOtpVerified"] = result?["isOtpVerified"] as? Bool ?? false
                    json["bank_detail"] = result?["bank_detail"] as? Int ?? 0
                    json["company_detail"] = result?["company_detail"] as? Int ?? 0
                    json["document_detail"] = result?["document_detail"] as? Int ?? 0
                    json["gst_detail"] = result?["gst_detail"] as? Int ?? 0
                    json["referal_code"] = result?["referal_code"] as? String ?? ""
                    json["token"] = result?["token"] as? String ?? ""
                    UserDefaults.standard.set(aRegistrationType.rawValue, forKey: OldUserType)
                    UserDefaults.standard.synchronize()
                    let aLoginModel = LoginModel(fromDictionary:json)
                    aLoginSuccess(aLoginModel)
                }else {
                    let msg = result?["message"] as? String ?? Someerror
                    let errorTemp = NSError(domain: "", code: 201,
                                            userInfo: [NSLocalizedDescriptionKey: msg])
                    aFailed(errorTemp)
                }
            }else {
                aFailed(error)
            }
        }
    }
}
