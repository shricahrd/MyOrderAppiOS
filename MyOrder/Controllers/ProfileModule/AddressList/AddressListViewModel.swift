//
//  AddressListViewModel.swift
//  MyOrder
//
//  Created by gwl on 20/10/20.
//

import UIKit
typealias AddressListSuccess = (_ models: [AddressListModel]) -> Void
typealias AddDefultAddressSuccess = (_ msg: String) -> Void

class AddressListViewModel: NSObject {
    func aGetAddressListServiceCall(aAddressListSuccess:@escaping  AddressListSuccess,
                                aFailed:@escaping  Failed) {
        
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]

        ApiService.shared.callServiceWith(apiName: kAddressList, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["user_address"] as? [[String: Any]] ?? []
                var aAddressListModel: [AddressListModel] = []
                for objectAddressListModel in object {
                    aAddressListModel.append(AddressListModel(fromDictionary: objectAddressListModel))
                }
                aAddressListSuccess(aAddressListModel)
            }else {
                aFailed(error)
            }
        }
    }
    
    func updateDefaultAddressServiceCall(aFld_address_id: Int,
                              aFld_address_default: Int,
                              aAddDefultAddressSuccess: @escaping AddDefultAddressSuccess,
                              aFailed: @escaping Failed) {
        let jsonReq = ["fld_address_default": aFld_address_default,
                       "fld_address_id": aFld_address_id,
                       "fld_user_id": UserModel.shared.fld_user_id,
                       "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kAddDefaultAddress, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddDefultAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    
    func delteAddressServiceCall(aFld_address_id: Int,
                              aAddDefultAddressSuccess: @escaping AddDefultAddressSuccess,
                              aFailed: @escaping Failed) {
        let jsonReq = [
                       "fld_address_id": aFld_address_id,
                       "fld_user_id": UserModel.shared.fld_user_id,
                       "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kDeleteAddress, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddDefultAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    
}
