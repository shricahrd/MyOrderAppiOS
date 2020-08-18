//
//  AppUtilit.swift
//  Trolleey
//
//  Created by Ivica Technologies on 28/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: Any]

func parameter(type:APIRouter) -> JSONDictionary? {
    
    switch type {
    case .manufactureRegister(let name, let email, let password, let contactNumber, let devigeId):
        let parameters: JSONDictionary = [
            API.APIParameterKey.name:name,API.APIParameterKey.email:email,API.APIParameterKey.password:password,API.APIParameterKey.contactNumber:contactNumber,API.APIParameterKey.fldDeviceId:devigeId]
        
        return parameters
        
    case .stockistRegister(let name, let email, let password, let contactNumber, let devigeId):
        
        let parameters: JSONDictionary = [
            API.APIParameterKey.name:name,API.APIParameterKey.email:email,API.APIParameterKey.password:password,API.APIParameterKey.contactNumber:contactNumber,API.APIParameterKey.fldDeviceId:devigeId]
        
        return parameters
    case .distributorRegister(let name, let email, let password, let contactNumber, let devigeId):
        let parameters: JSONDictionary = [
            API.APIParameterKey.name:name,API.APIParameterKey.email:email,API.APIParameterKey.password:password,API.APIParameterKey.contactNumber:contactNumber,API.APIParameterKey.fldDeviceId:devigeId]
        
        return parameters
        
        
    case .retailerRegister(let name, let email, let password, let contactNumber, let devigeId):
        
        let parameters: JSONDictionary = [
            API.APIParameterKey.name:name,API.APIParameterKey.email:email,API.APIParameterKey.password:password,API.APIParameterKey.contactNumber:contactNumber,API.APIParameterKey.fldDeviceId:devigeId]
        
        return parameters
        
    case .salesagentRegister(let name, let email, let password, let contactNumber, let devigeId):
        let parameters: JSONDictionary = [
            API.APIParameterKey.name:name,API.APIParameterKey.email:email,API.APIParameterKey.password:password,API.APIParameterKey.contactNumber:contactNumber,API.APIParameterKey.fldDeviceId:devigeId]
        
        return parameters
    case .loginManufacture(let mobileNumber, let password):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserPhone:mobileNumber,API.APIParameterKey.fldUserPassword:password]
        
        return parameters
        
        
    case .loginstockfacture(let mobileNumber, let password):
        
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserPhone:mobileNumber,API.APIParameterKey.fldUserPassword:password]
        
        return parameters
        
    case .logindistributorfacture(let mobileNumber, let password):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserPhone:mobileNumber,API.APIParameterKey.fldUserPassword:password]
        
        return parameters
    case .loginretailerfacture(let mobileNumber, let password):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserPhone:mobileNumber,API.APIParameterKey.fldUserPassword:password]
        
        return parameters
        
    case .loginsalesagentfacture(let mobileNumber, let password):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserPhone:mobileNumber,API.APIParameterKey.fldUserPassword:password]
        
        return parameters
        
    case .VerifyManufactur(let userId, let Otp, let flag, let phoneNumber):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fldUserPassword:Otp,API.APIParameterKey.flag:flag,API.APIParameterKey.fld_user_phone:phoneNumber]
        
        return parameters
        
    case .Verifystockfacture(let userId, let Otp, let flag, let phoneNumber):
        
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fldUserPassword:Otp,API.APIParameterKey.flag:flag,API.APIParameterKey.fld_user_phone:phoneNumber]
        
        return parameters
    case .Verifydistributorfacture(let userId, let Otp, let flag, let phoneNumber):
        
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fldUserPassword:Otp,API.APIParameterKey.flag:flag,API.APIParameterKey.fld_user_phone:phoneNumber]
        
        return parameters
    case .Verifyretailerfacture(let userId, let Otp, let flag, let phoneNumber):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fldUserPassword:Otp,API.APIParameterKey.flag:flag,API.APIParameterKey.fld_user_phone:phoneNumber]
        
        return parameters
        
    case .Verifysalesagentfacture(let userId, let Otp, let flag, let phoneNumber):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fldUserPassword:Otp,API.APIParameterKey.flag:flag,API.APIParameterKey.fld_user_phone:phoneNumber]
        
        return parameters
    case .hotDeals(let productType, let pageNumber):
        
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_product_type:productType,API.APIParameterKey.fld_page_no:pageNumber]
        
        return parameters
    case .produNmae(let fldBrandId, let fldCatCid, let fldUserId, let fldSearchTxt, let fldPageNo, let fldSortBy):
        
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_brand_id:fldBrandId,API.APIParameterKey.fld_cat_id:fldCatCid,API.APIParameterKey.fldUserId:fldUserId,API.APIParameterKey.fld_search_txt:fldSearchTxt,API.APIParameterKey.fld_page_no:fldPageNo,API.APIParameterKey.fld_sort_by:fldSortBy]
        
        return parameters
        
    case .wishList(let fldUserId):
        
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:fldUserId]
        
        return parameters
    case .stateLis:
        
        return nil
    case .cityList(let stateCode):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_state_id:stateCode]
        
        return parameters
        
    case .areaList(let stateId, let cityId):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_state_id:stateId,API.APIParameterKey.fld_city_id:cityId]
        return parameters
    }
}


fileprivate var DefoultDataParameters: JSONDictionary{
//    if Singleton.Properties.shared.user != nil{
//        return [
//            API.APIParameterKey.user_Type : API.APIParameterValue.userType
//        ]
//    }
    return [:]
}


