//
//  SignUpViewModel.swift
//  MyOrder
//
//  Created by sourabh on 09/10/20.
//

import UIKit

typealias SignUpSuccess = (_ value: SignUpModel?) -> Void

class  SignUpViewModel: NSObject {
    
    func registrationServiceCall(aRegistrationType: UserType,
                                 aUsername:String,
                                 aMobile:String,
                                 aPassword:String,
                                 aEmail:String,
                                 aSignUpSuccess:@escaping  SignUpSuccess,
                                 aFailed:@escaping  Failed){
        
        let jsonRequest = ["name":aUsername,
                           "contact_number":aMobile,
                           "password":aPassword,
                           "email":aEmail,
                           "fld_device_id":"ios",
                           "referal_code":""]

        var registerFor = kManufactureRegister
        switch aRegistrationType {
        case .manufacture:
            registerFor = kManufactureRegister
        case .stockist:
            registerFor = kStockistRegister
        case .distributor:
            registerFor = kDistributorRegister
        case .retailer:
            registerFor = kRetailerRegister
        case .agent:
            registerFor = kManufactureRegister
        default:
            registerFor = kSalesagentRegister
        }
        ApiService.shared.callServiceWith(apiName: registerFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let aSignUpModel = SignUpModel(fromDictionary: result?["register_data"] as? [String: Any] ?? [:])
                aSignUpSuccess(aSignUpModel)
            }else {
                aFailed(error)
            }
        }
    }
}
