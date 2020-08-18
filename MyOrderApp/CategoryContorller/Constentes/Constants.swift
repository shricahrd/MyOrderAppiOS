//
//  Constants.swift
//  Trolleey
//
//  Created by Ivica Technologies on 28/05/20.
//  Copyright © 2020 Brainiuminfotech. All rights reserved.
//

import Foundation

var serverLink = "https://aptechbangalore.com/myorder/api/"

struct API {
struct ProductionServer {
    static let baseURL: (APIRouter?) -> String = { router in
        guard let _router = router else {
            return serverLink
        }
        return serverLink
    }
}
    
//    struct APIParameterValue {
//           static var userType: String{
//            //return Singleton.Properties.shared.user?.userDetails.userType ?? ""
//           }
//    }
    
    
    struct APIParameterKey {
        static let name = "name"
        static let email = "email"
        static let password = "password"
        static let contactNumber = "contact_number"
        static let fldDeviceId = "fld_device_id"
        static let fldUserPhone = "fld_user_phone"
        static let fldUserPassword = "fld_user_password"
        static let fldUserId = "fld_user_id"
        static let otp = "otp"
        static let flag = "flag"
        static let fld_user_phone = "fld_user_phone"
        static let fld_product_type = "fld_product_type"
        static let fld_page_no = "fld_page_no"
        static let fld_brand_id = "fld_brand_id"
        static let fld_cat_id = "fld_cat_id"
        static let fld_search_txt = "fld_search_txt"
        static let fld_sort_by = "fld_sort_by"
        static let fld_state_id = "fld_state_id"
        static let fld_city_id = "fld_city_id"


        

        
        
        
        
        
        
        
        


        
        
        
        



        
        
        
        

        
        
        

        
        
        
        
        
    }
    
    

}
