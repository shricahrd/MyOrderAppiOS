//
//  APIRouter.swift
//  Trolleey
//
//  Created by Ivica Technologies on 28/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import Foundation
import Alamofire



//struct API {
//
//    struct Baseurlrequest {
//        static let BasUrl = "https://nodeserver.brainiuminfotech.com:2000/api/"
//    }
//
//}


enum HTTPHeaderField: String {
    case ContentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
}


enum APIRouter: URLRequestConvertible {
   // case getAllCities
    case manufactureRegister(name:String,email:String,password:String,contactNumber:String,devigeId:String)
    
    case stockistRegister(name:String,email:String,password:String,contactNumber:String,devigeId:String)
    case distributorRegister(name:String,email:String,password:String,contactNumber:String,devigeId:String)
    case retailerRegister(name:String,email:String,password:String,contactNumber:String,devigeId:String)
    case salesagentRegister(name:String,email:String,password:String,contactNumber:String,devigeId:String)
// LOGINTypes
    
    case loginManufacture(mobileNumber:String,password:String)
    case loginstockfacture(mobileNumber:String,password:String)
    case logindistributorfacture(mobileNumber:String,password:String)
    case loginretailerfacture(mobileNumber:String,password:String)
    case loginsalesagentfacture(mobileNumber:String,password:String)

// FORGOT PASSWORD
    
    
    // VERIFEY OTP
    case VerifyManufactur(userId:String,Otp:String,flag:String,phoneNumber:String)
    case Verifystockfacture(userId:String,Otp:String,flag:String,phoneNumber:String)
    case Verifydistributorfacture(userId:String,Otp:String,flag:String,phoneNumber:String)
    case Verifyretailerfacture(userId:String,Otp:String,flag:String,phoneNumber:String)
    case Verifysalesagentfacture(userId:String,Otp:String,flag:String,phoneNumber:String)
// HOME API
    
    case hotDeals(productType:String,pageNumber:Int)
    case newCollection(productType:String,pageNumber:Int)
  
   // case loginManufacture(mobileNumber:String,flg:String)
    // PRODUCT NAME
    case produNmae(fldBrandId:String,fldCatCid:String,fldUserId:String,fldSearchTxt:String,fldPageNo:Int,fldSortBy:String)
    // WISH LIST
    case banners
    case wishList(fldUserId:String)
    case homeProducts(fldPageNo:String)
    
    case filtersnew(fldbrandid: String,fldcatid: String,fldsearchtxt: String)

    //STATE LIST
    case stateLis
    case cityList(stateCode:String)
    case areaList(stateId:String,cityId:String)
    case productdetailes(productID:String,userId:String, colourId:String, sizeId:String)
    case productsearch(userId:String, SearchTxt:String)
    case wishlistAddUpdate(userId:String, productId:String, actionType:String)
    case brand(fldPageNo:String)
    case filters(fldbrandid: String, fldcatid: String, fldsearchtxt: String)
    case filterValue(fldbrandid: String, fldcatid: String,fldfilterstype: String,fldsearchtxt: String)
    
    case filterProduct(fldcatid: String,fldbrandid: String,fldsizeid: String, fldcolorid: String, fldmaxprice: String, fldminprice: String,fldpageno: String, flduserid: String, fldmaterialid: String, fldotherid: String,fldsortby: String, fldsearchtxt: String, fldscatid: String)
    
//    {
//    "fld_cat_id":"2",
//    "fld_brand_id":"",
//    "fld_size_id":"",
//    "fld_color_id":"",
//    "fld_max_price":"",
//    "fld_min_price":"",
//    "fld_page_no":"",
//    "fld_user_id":"",
//    "fld_material_id":"",
//    "fld_other_id":"",
//    "fld_sort_by":"",
//    "fld_search_txt":"",
//    "fld_scat_id":""
//    }
//    {
//    "fld_brand_id":"",
//    "fld_cat_id":2,
//    "fld_filters_type":1,
//    "fld_search_txt":""
//    }
//    "fld_brand_id":"",
//    "fld_cat_id":2,
//    "fld_search_txt":""
//    {
//    "fld_product_id":1,
//    "fld_user_id":1,
//    "fld_color_id":"",
//    "fld_size_id":""
//    }

//    {
//    "fld_user_id":1,
//    "fld_product_id":1,
//    "fld_action_type":0
//    }

//    "fld_user_id":1,
//    "fld_search_txt":"simple"

    private var path: String {
        switch self {
      
        case.manufactureRegister:
            return "manufacture_register"
        case.stockistRegister:
            return "stockist_register"
        case.distributorRegister:
            return "distributor_register"
        case.retailerRegister:
            return "retailer_register"
        case.salesagentRegister:
            return "salesagent_register"
        case.loginManufacture:
            return "manufacture_login"
        case.loginstockfacture:
            return "stockist_login"
        case.logindistributorfacture:
            return "distributor_login"
        case.loginretailerfacture:
            return "retailer_login"
        case.loginsalesagentfacture:
            return "salesagent_login"
        case.VerifyManufactur:
            return "manufacture_forget_verify"
        case.Verifystockfacture:
            return "stockist_forget_verify"
        case.Verifydistributorfacture:
            return "distributor_forget_verify"
        case.Verifyretailerfacture:
            return "retailer_forget_verify"
        case.Verifysalesagentfacture:
            return "salesagent_forget_verify"
        case.hotDeals:
            return "homeProduct"
        case.produNmae:
            return "product"
        case.wishList:
            return "wishlist"
        case.stateLis:
            return "state_listing"
        case.cityList:
            return "city_listing"
        case.areaList:
            return "area_listing"
        case.productdetailes:
            return "productdetailes"
        case.productsearch:
             return "productsearch"
        case.wishlistAddUpdate:
             return "wishlist_add_update"
        case.brand:
             return "brand"
        case.filters:
            return "filters"
        case.filterValue:
            return "filters_value"
        case.filterProduct:
            return "filterProduct"
        case.banners:
            return "banners"
        case.newCollection:
            return "new_collection"
        case.homeProducts:
            return "homeProducts"
        case.filtersnew:
            return "filtersnew"
        default:
            break
        }
    }

    private var methods:HTTPMethod {
        switch self {
        case.manufactureRegister, .stockistRegister, .distributorRegister, .retailerRegister, .salesagentRegister,.loginManufacture, .loginstockfacture, .logindistributorfacture, .loginretailerfacture, .loginsalesagentfacture, .VerifyManufactur, .Verifystockfacture, .Verifydistributorfacture, .Verifyretailerfacture,.Verifysalesagentfacture, .hotDeals,.produNmae, .wishList, .cityList,.areaList,.productdetailes,.productsearch,.wishlistAddUpdate,.brand,.filters,.filterValue,.filterProduct,.banners,.newCollection,.homeProducts,.filtersnew:
            return.post
        case.stateLis:
            return .get
        default:
            break
        }
    }
    
        
    
    
    
    
    
    
    
    
    
    
    
 /// API URLSESSION
    
    func asURLRequest() throws -> URLRequest {
        
        let URL = try  API.ProductionServer.baseURL(self).asURL()
        var urlRequest = URLRequest(url: URL.appendingPathComponent(path))
        urlRequest.httpMethod = methods.rawValue
        
       urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        if let tocken = Singleton.Properties.shared.user?.authToken {
//        
//        urlRequest.addValue("Bearer \(tocken)", forHTTPHeaderField: "Authorization")
//        
//        }

        if let parameter = parameter(type: self){
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameter, options: [])
            } catch {
                //throw AFError.parameterEncoderFailed(reason: T##AFError.ParameterEncoderFailureReason)
                
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
    
}
