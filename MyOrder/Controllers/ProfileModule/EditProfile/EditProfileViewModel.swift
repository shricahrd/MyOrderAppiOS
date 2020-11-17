//
//  EditProfileViewModel.swift
//  MyOrder
//
//  Created by gwl on 20/10/20.
//

import UIKit

class EditProfileViewModel: NSObject {
    func updatePersonalInfoServiceCall(aimage: UIImage? = nil,
                                aFullName: String,
                                aEmail: String,
                                aMobile: String,
                                aAddress: String,
                                aState: String,
                                aCity: String,
                                aArea: String,
                                aPincode: String,
                                aAddAddressSuccess:@escaping  AddAddressSuccess,
                                aFailed:@escaping  Failed) {
        
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "owner_name": aFullName,
                       "email": aEmail,
                       "contact_number": aMobile,
                       "address":aAddress,
                       "state":aState,
                       "city":aCity,
                       "area":aArea,
                       "pincode":aPincode,
                        ] as [String : Any]
        

        var registerFor = kManufactureProfileUpdate
        switch UserModel.shared.aSelectedUserType {
        case .manufacture:
            registerFor = kManufactureProfileUpdate
        case .stockist:
            registerFor = kStockistProfileUpdate
        case .distributor:
            registerFor = kDistributorProfileUpdate
        case .retailer:
            registerFor = kRetailerProfileUpdate
        case .agent:
            registerFor = kAgentProfileUpdate
        default:
            registerFor = kManufactureProfileUpdate
        }
        
        if aimage != nil, let imgData = aimage!.jpegData(compressionQuality: 1) {
            ApiService.shared.uploadImageServiceCall(image: imgData, apiName: registerFor, fileName: "profile_pic", parameter: jsonReq) { (result, error) in
                if error == nil {
                    let aMessage = result?["message"] as? String ?? ""
                    aAddAddressSuccess(aMessage)
                }else {
                    aFailed(error)
                }
            }
        }else {
            ApiService.shared.callServiceWith(apiName: registerFor, parameter: jsonReq, methods:  .post) { (result, error) in
                if error == nil {
                    let aMessage = result?["message"] as? String ?? ""
                    aAddAddressSuccess(aMessage)
                }else {
                    aFailed(error)
                }
            }
        }
    }
}
