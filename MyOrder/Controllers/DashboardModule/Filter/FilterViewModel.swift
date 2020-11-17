//
//  FilterViewModel.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit
typealias FilterModelSuccess = (_ model: FilterModel) -> Void

class FilterViewModel: NSObject {
    func getFilterss(afld_brand_id: Int,
                     afld_cat_id: Int,
                     afld_search_txt: String,
                     aFilterModelSuccess: @escaping FilterModelSuccess,
                     aFailed:@escaping  Failed) {
        let jsonReq = [
                       "fld_cat_id":afld_cat_id,
                       ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kFiltersnew, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                var aPricedata = Pricedata()
                var aCategorydata: [Categorydata] = []
                var aBranddata: [Branddata] = []
                var aColordata: [Colordata] = []
                var aSizedata: [Sizedata] = []
                var id: Int = 0
                var name: String = ""
                if let objects = result?["price_data"] as? [String: Any] {
                    aPricedata = Pricedata(aMinPrice: objects["min_price"] as! Int,
                                           aMaxPrice: objects["max_price"] as! Int,
                                           aFldFilterType: objects["fld_filter_type"] as! String)
                }
                if let objects = result?["category_data"] as? [[String: Any]] {
                    for object in objects {
                        let cat = Categorydata(aCatId: object["fld_cat_id"] as! Int,
                                               aCatName: object["fld_cat_name"] as! String)
                        aCategorydata.append(cat)
                    }
                } 
                if let objects = result?["brand_data"] as? [[String: Any]] {
                    for object in objects {
                        let brnd = Branddata(aFidId: object["fld_id"] as! Int,
                                             aFidName: object["fld_name"] as! String,
                                             aFldFilterType: object["fld_filter_type"] as! String)
                        aBranddata.append(brnd)
                    }
                }
                if let objects = result?["color_data"] as? [[String: Any]] {
                    for object in objects {
                        let color = Colordata(aFidId: object["fld_id"] as! Int,
                                              aFidName: object["fld_name"] as! String,
                                              aFidCode: object["fld_code"] as! String,
                                              aFldFilterType: object["fld_filter_type"] as! String)
                        aColordata.append(color)
                    }
                }
                if let objects = result?["size_data"] as? [[String: Any]] {
                    for object in objects {
                        let size = Sizedata(aFidId: object["fld_id"] as! Int,
                                            aFidName: object["fld_name"] as! String,
                                            aFldFilterType: object["fld_filter_type"] as! String)
                        aSizedata.append(size)
                    }
                }
                id = result?["id"] as? Int ?? 0
                name = result?["name"] as? String ?? ""
                let afld_total_page = result?["fld_total_page"] as? Int ?? 0
                let anext_page = result?["next_page"] as? Int ?? 0
                let modelFilterModel = FilterModel(aaPricedata: aPricedata,
                            aaCategorydata: aCategorydata,
                            aaBranddata: aBranddata,
                            aaColordata: aColordata,
                            aaSizedata: aSizedata,
                            aName: name,
                            aId: id,
                            afld_total_page: afld_total_page,
                            aNextPage: anext_page)
                aFilterModelSuccess(modelFilterModel)
            }else {
                aFailed(error)
            }
        }
    }
}
