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
    case .productdetailes(let productID, let userId, let colourId,let sizeId):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_product_id:productID,API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fld_color_id:colourId,API.APIParameterKey.fld_size_id:sizeId]
        return parameters
    case .productsearch(let userId, let SearchTxt):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId,API.APIParameterKey.fld_search_txt:SearchTxt]
        return parameters
    case .wishlistAddUpdate(let userId, let productId, let actionType):
        let parameters: JSONDictionary = [ API.APIParameterKey.fldUserId:userId, API.APIParameterKey.fld_product_id:productId, API.APIParameterKey.fld_action_type:actionType]
        return parameters
    case .brand(let fldPageNo):
         let parameters: JSONDictionary = [ API.APIParameterKey.fld_page_no:fldPageNo]
         return parameters
    case .filters(let fldbrandid, let fldcatid, let fldsearchtxt):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_brand_id:fldbrandid, API.APIParameterKey.fld_cat_id:fldcatid, API.APIParameterKey.fld_search_txt:fldsearchtxt]
        return parameters
    case .filterValue(let fldbrandid, let fldcatid, let fldfilterstype, let fldsearchtxt):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_brand_id:fldbrandid, API.APIParameterKey.fld_cat_id:fldcatid, API.APIParameterKey.fld_filters_type: fldfilterstype, API.APIParameterKey.fld_search_txt:fldsearchtxt]
        return parameters
    case .filterProduct(let fldcatid, let fldbrandid,  let fldsizeid,  let fldcolorid,let fldmaxprice,  let fldminprice,  let fldpageno, let flduserid, let fldmaterialid, let fldotherid,let fldsortby, let fldsearchtxt,  let fldscatid):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_cat_id:fldcatid, API.APIParameterKey.fld_brand_id:fldbrandid, API.APIParameterKey.fld_size_id: fldsizeid, API.APIParameterKey.fld_color_id:fldcolorid, API.APIParameterKey.fld_max_price:fldmaxprice, API.APIParameterKey.fld_min_price:fldminprice, API.APIParameterKey.fld_page_no: fldpageno, API.APIParameterKey.fldUserId:flduserid, API.APIParameterKey.fld_material_id: fldmaterialid, API.APIParameterKey.fld_other_id: fldotherid, API.APIParameterKey.fld_sort_by:fldsortby,  API.APIParameterKey.fld_search_txt:fldsearchtxt, API.APIParameterKey.fld_scat_id:fldscatid]
        return parameters
    case .banners:
        let parameters: JSONDictionary = [:]
        return parameters
    case .newCollection(let productType, let pageNumber):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_product_type:productType, API.APIParameterKey.fld_page_no:pageNumber]
        return parameters

    case .homeProducts(let fldPageNo):
        let parameters: JSONDictionary = [ API.APIParameterKey.fld_page_no:fldPageNo]
        return parameters
    case .filtersnew(let fldbrandid, let fldcatid, let fldsearchtxt):
        let parameters: JSONDictionary = [API.APIParameterKey.fld_brand_id:fldbrandid,API.APIParameterKey.fld_cat_id:fldcatid, API.APIParameterKey.fld_search_txt: fldsearchtxt]
        return parameters
    }
}

//{
//"fld_brand_id":"",
//"fld_cat_id":2,
//"fld_search_txt":""
//}
//{
//"fld_cat_id":"2",
//"fld_brand_id":"",
//"fld_size_id":"",
//"fld_color_id":"",
//"fld_max_price":"",
//"fld_min_price":"",
//"fld_page_no":"",
//"fld_user_id":"",
//"fld_material_id":"",
//"fld_other_id":"",
//"fld_sort_by":"",
//"fld_search_txt":"",
//"fld_scat_id":""
//}

//{
//"fld_brand_id":"",
//"fld_cat_id":2,
//"fld_filters_type":1,
//"fld_search_txt":""
//}
//    "fld_brand_id":"",
//    "fld_cat_id":2,
//    "fld_search_txt":""



fileprivate var DefoultDataParameters: JSONDictionary{
//    if Singleton.Properties.shared.user != nil{
//        return [
//            API.APIParameterKey.user_Type : API.APIParameterValue.userType
//        ]
//    }
    return [:]
}


