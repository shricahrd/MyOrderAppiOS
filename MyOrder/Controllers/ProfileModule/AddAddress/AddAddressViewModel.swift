//
//  AddAddressViewModel.swift
//  MyOrder
//
//  Created by sourabh on 20/10/20.
//

import UIKit

typealias AddAddressSuccess = (_ msg: String) -> Void
typealias StateListSuccess = (_ model: [StateList]) -> Void
typealias CityListSuccess = (_ model: [CityList]) -> Void
typealias AreaListSuccess = (_ model: [AreaList]) -> Void

class AddAddressViewModel: NSObject {
    func aAddAddressServiceCall(aFullName: String,
                                aAddress: String,
                                aCity: String,
                                aState: String,
                                aCountry: String,
                                aZip: String,
                                aArea: String,
                                aAddAddressSuccess:@escaping  AddAddressSuccess,
                                aFailed:@escaping  Failed) {
        
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_user_phone": UserModel.shared.fld_user_phone,
                       "fld_user_email": UserModel.shared.fld_user_email,
                       "fld_user_name": aFullName,
                       "fld_user_city": aCity,
                       "fld_user_address": aAddress,
                       "fld_user_state": aState,
                       "fld_user_pincode": aZip,
                       "fld_user_country": aCountry,
                       "fld_user_locality": "",
                       "fld_user_area":aArea,
                       "fld_address_type": 2,
                       "fld_address_default": 0,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kAddAddress, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    
    func aUpdateAddressServiceCall(aFullName: String,
                                   aAddress: String,
                                   aCity: String,
                                   aState: String,
                                   aCountry: String,
                                   aArea: String,
                                   aZip: String,
                                   aAddressListModel: AddressListModel,
                                   aAddAddressSuccess:@escaping  AddAddressSuccess,
                                   aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_user_phone": UserModel.shared.fld_user_phone,
                       "fld_user_email": UserModel.shared.fld_user_email,
                       "fld_user_name": aFullName,
                       "fld_user_city": aCity,
                       "fld_user_address": aAddress,
                       "fld_user_state": aState,
                       "fld_user_pincode": aZip,
                       "fld_user_country": aCountry,
                       "fld_address_id": aAddressListModel.fld_address_id,
                       "fld_user_locality": "",
                       "fld_user_area":aArea,
                       "fld_address_type": 2,
                       "fld_address_default": aAddressListModel.fld_address_default,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kUpdateAddress, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aAddAddressSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    func getStates(aStateListSuccess:@escaping  StateListSuccess,
                   aFailed:@escaping  Failed){
        ApiService.shared.callServiceWith(apiName: kStateList, parameter: nil, methods:  .get) { (result, error) in
            if error == nil {
                let aObjects = result?["state_data"] as? [[String: Any]] ?? []
                var aStateList: [StateList] = []
                aObjects.forEach { object in
                    aStateList.append(StateList(fromDictionary: object))
                }
                aStateListSuccess(aStateList)
            }else {
                aFailed(error)
            }
        }
    }
    func getCitys(aStateID: Int,
                  aCityListSuccess:@escaping  CityListSuccess,
                  aFailed:@escaping  Failed){
        ApiService.shared.callServiceWith(apiName: kCityList, parameter: ["fld_state_id":aStateID], methods:  .post) { (result, error) in
            if error == nil {
                let aObjects = result?["city_data"] as? [[String: Any]] ?? []
                var aStateList: [CityList] = []
                aObjects.forEach { object in
                    aStateList.append(CityList(fromDictionary: object))
                }
                aCityListSuccess(aStateList)
            }else {
                aFailed(error)
            }
        }
    }
    func getAreas(aStateID: Int,
                 aCityID: Int,
                  aAreaListSuccess:@escaping  AreaListSuccess,
                  aFailed:@escaping  Failed){
        ApiService.shared.callServiceWith(apiName: kAreaList, parameter: ["fld_state_id": aStateID, "fld_city_id": aCityID], methods:  .post) { (result, error) in
            if error == nil {
                let aObjects = result?["area_data"] as? [[String: Any]] ?? []
                var aStateList: [AreaList] = []
                aObjects.forEach { object in
                    aStateList.append(AreaList(fromDictionary: object))
                }
                aAreaListSuccess(aStateList)
            }else {
                aFailed(error)
            }
        }
    }
}


