//
//  ProfileViewModel.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//

import UIKit

typealias ProfileModelSuccess = (_ model: ProfileModel) -> Void

class ProfileViewModel: NSObject {
    func userProfileServiceCall( aProfileModelSuccesss:@escaping  ProfileModelSuccess,
                                 aFailed:@escaping  Failed) {
        let jsonRequest = ["fld_user_id": UserModel.shared.fld_user_id,
                           "panel_type":UserModel.shared.aSelectedUserType.rawValue]
        var registerFor = kManufactureProfile
        switch UserModel.shared.aSelectedUserType {
        case .manufacture:
            registerFor = kManufactureProfile
        case .stockist:
            registerFor = kStockistProfile
        case .distributor:
            registerFor = kDistributorProfile
        case .retailer:
            registerFor = kRetailerProfile
        case .agent:
            registerFor = kAgentProfile
        default:
            registerFor = kManufactureProfile
        }
        ApiService.shared.callServiceWith(apiName: registerFor, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let json = result?["profile_data"] as? [String: Any] ?? [:]
                let aCompanyInfo = CompanyInfo(fromDictionary: json["company_info"] as? [String: Any] ?? [:])
                let aDocumentInfo = DocumentInfo(fromDictionary: json["document_info"] as? [String: Any] ?? [:])
                let aPersonalInfo = PersonalInfo(fromDictionary: json["personal_info"] as? [String: Any] ?? [:])
                let aShippingInfo = ShippingInfo(fromDictionary: json["shipping_info"] as? [String: Any] ?? [:])
                let aProfileModel = ProfileModel(aaCompanyInfo: aCompanyInfo, aaDocumentInfo: aDocumentInfo, aaPersonalInfo: aPersonalInfo, aaShippingInfo: aShippingInfo)
                aProfileModelSuccesss(aProfileModel)
            } else {
                aFailed(error)
            }
        }
    }
}
