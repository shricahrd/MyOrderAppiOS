//
//  WearlistViewModel.swift
//  MyOrder
//
//  Created by sourabh on 11/10/20.
//

import UIKit
typealias WearlistSuccess = (_ model: WearlistModel) -> Void
typealias CatagoryslistSuccess = (_ model: [Catagorys]) -> Void

class WearlistViewModel:NSObject {
    
    func getArrayToLoad(indexSelected: Int) -> [WearlistModel] {
        var array: [WearlistModel] = []
//        if indexSelected == 0 {
//            array.append(WearlistModel(atitle: "Top wear", aisHeading: true, imageName: "plus", anumber: 1))
//            array.append(WearlistModel(atitle: "Bottom wear", aisHeading: true, imageName: "plus", anumber: 2))
//            array.append(WearlistModel(atitle: "Accessories", aisHeading: true, imageName: "plus", anumber: 3))
//        }
//        if indexSelected == 1 {
//            array.append(WearlistModel(atitle: "Top wear", aisHeading: true, imageName: "minus", anumber: 1))
//            array.append(WearlistModel(atitle: "T-shirt", aisHeading: false, imageName: "minus", anumber: 1))
//            array.append(WearlistModel(atitle: "Full-shirt", aisHeading: false, imageName: "minus", anumber: 1))
//            array.append(WearlistModel(atitle: "Bottom wear", aisHeading: true, imageName: "plus", anumber: 2))
//            array.append(WearlistModel(atitle: "Accessories", aisHeading: true, imageName: "plus", anumber: 3))
//        }
//        if indexSelected == 2 {
//            array.append(WearlistModel(atitle: "Top wear", aisHeading: true, imageName: "plus", anumber: 1))
//            array.append(WearlistModel(atitle: "Bottom wear", aisHeading: true, imageName: "minus", anumber: 2))
//            array.append(WearlistModel(atitle: "Jeans", aisHeading: false, imageName: "minus", anumber: 2))
//            array.append(WearlistModel(atitle: "Pants", aisHeading: false, imageName: "minus", anumber: 2))
//            array.append(WearlistModel(atitle: "Accessories", aisHeading: true, imageName: "plus", anumber: 3))
//        }
//        if indexSelected == 3 {
//            array.append(WearlistModel(atitle: "Top wear", aisHeading: true, imageName: "plus", anumber: 1))
//            array.append(WearlistModel(atitle: "Bottom wear", aisHeading: true, imageName: "plus", anumber: 2))
//            array.append(WearlistModel(atitle: "Accessories", aisHeading: true, imageName: "minus", anumber: 3))
//            array.append(WearlistModel(atitle: "Belt", aisHeading: false, imageName: "minus", anumber: 3))
//            array.append(WearlistModel(atitle: "Goggles", aisHeading: false, imageName: "minus", anumber: 3))
//        }
        return array
    }
    
    func getCatagorys(afld_page_no: Int,
                      fld_cat_id: Int?,
                      aWearlistSuccess:@escaping  WearlistSuccess,
                      aFailed:@escaping  Failed) {
        let jsonRequest = ["fld_page_no": afld_page_no,
                           "fld_cat_id" : fld_cat_id!]
        ApiService.shared.callServiceWith(apiName: kCategory, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["category_data"] as? [[String: Any]] ?? []
                var aCatagorys: [Catagorys] = []
                for (index, objectCatagorys) in object.enumerated() {
                    aCatagorys.append(Catagorys(fromDictionary: objectCatagorys, aNumber: index+1, isHeading:true))
                }
                let afld_total_page = result?["fld_total_page"] as? Int ?? 0
                let anext_page = result?["next_page"] as? Int ?? 0
                let aWearlistModel = WearlistModel(afld_total_page: afld_total_page, anextPage: anext_page, aCatagorys: aCatagorys)
                aWearlistSuccess(aWearlistModel)
            }else {
                aFailed(error)
            }
        }
    }
    func getSubCatagorys(afld_page_no: Int,
                      fld_cat_id: Int,
                      nuber: Int,
                      aCatagoryslistSuccess:@escaping  CatagoryslistSuccess,
                      aFailed:@escaping  Failed){
        let jsonRequest = ["fld_page_no": afld_page_no,
                           "fld_cat_id" : fld_cat_id]
        ApiService.shared.callServiceWith(apiName: kCategory, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["category_data"] as? [[String: Any]] ?? []
                var aCatagorys: [Catagorys] = []
                for objectCatagorys in object {
                    aCatagorys.append(Catagorys(fromDictionary: objectCatagorys, aNumber: nuber, isHeading:false))
                }
                aCatagoryslistSuccess(aCatagorys)
            }else {
                aFailed(error)
            }
        }
    }
}
