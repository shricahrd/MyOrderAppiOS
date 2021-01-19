//
//  SearchProductViewModel.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit
typealias SearchProductModelSuccess = (_ model: [SearchProductModel]) -> Void

class SearchProductViewModel: NSObject {
    
    func aSerachListServiceCall(aText: String,
                                aSearchProductModelSuccess:@escaping  SearchProductModelSuccess,
                                aFailed:@escaping  Failed) {
        let jsonReq = ["fld_user_id":UserModel.shared.fld_user_id,
                       "fld_search_txt": aText,
                       ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kProductSearch, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["product_search_data"] as? [[String: Any]] ?? []
                var aSearchProducts: [SearchProductModel] = []
                object.forEach { order in
                    aSearchProducts.append(SearchProductModel(fromDictionary: order))
                }
                aSearchProductModelSuccess(aSearchProducts)
            }else {
                aFailed(error)
            }
        }
    }
}
