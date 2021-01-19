//
//  DashboardViewModel.swift
//  MyOrder
//
//  Created by sourabh on 10/10/20.
//

import UIKit
typealias DashboardSuccess = (_ model: DashboardModel) -> Void
typealias CatagorysSuccess = (_ model: [Catagorys]) -> Void
typealias DashboardProductSuccess = (_ model: [DashboardProduct]) -> Void



class DashboardViewModel: NSObject{
    func dasshboardProductServiceCall(afld_page_no: Int,
                                      aDashboardSuccess:@escaping  DashboardSuccess,
                                      aFailed:@escaping  Failed){
        let jsonRequest = ["fld_page_no": afld_page_no,
                           "panel_type": UserModel.shared.aSelectedUserType.rawValue,
                           "fld_user_id": UserModel.shared.fld_user_id
        ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kDashboardHomeProducts, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let banner = result?["banner_data_listing"] as? [[String: Any]] ?? []
                let object = result?["Home_Product_Listing"] as? [[String: Any]] ?? []
                var aBanner: [DashboardBanner] = []
                for objectbanner in banner {
                    aBanner.append(DashboardBanner(fromDictionary: objectbanner))
                }
                let hotDeals = object.first!
                var aHotProduct: [DashboardProduct] = []
                for objecthot in hotDeals["home_data"] as! [[String: Any]] {
                    aHotProduct.append(DashboardProduct(fromDictionary: objecthot))
                }
                let aHotDealsObject = DashboardHotDeals(dashboardProduct: aHotProduct, atitle: hotDeals["title"] as? String ?? "", index: hotDeals["next_page"] as? Int ?? 0)
                let newCollections = object.last!
                var aNewProduct: [DashboardProduct] = []
                for objectNew in newCollections["home_data"] as! [[String: Any]] {
                    aNewProduct.append(DashboardProduct(fromDictionary: objectNew))
                }
                let aNewCollectionObject = DashboardNewCollection(product: aNewProduct, atitle: newCollections["title"] as? String ?? "", index: newCollections["next_page"] as? Int ?? 0)
                let afld_total_page = result?["fld_total_page"] as? Int ?? 0
                let anext_page = result?["next_page"] as? Int ?? 0
                UserModel.shared.aCartTotalCount = result?["cart_count"] as? Int ?? 0
                let aDashboardModel = DashboardModel(aDashboardBanner: aBanner,
                                                     aDashboardHotDeals: aHotDealsObject,
                                                     aDashboardNewCollection: aNewCollectionObject,
                                                     afld_total_page: afld_total_page,
                                                     anextPage: anext_page)
                aDashboardSuccess(aDashboardModel)
            }else {
                aFailed(error)
            }
        }
    }
    
//    func featchMoreProductsServiceCall(productListType: ProductListType,
//                                afld_page_no: Int,
//                                aDashboardProductSuccess:@escaping  DashboardProductSuccess,
//                                aFailed:@escaping  Failed){
//        let jsonRequest = ["fld_product_type": productListType.rawValue,
//                           "fld_page_no": afld_page_no,
//                           "panel_type": UserModel.shared.aSelectedUserType.rawValue,
//                           "fld_user_id": UserModel.shared.fld_user_id
//        ] as [String : Any]
//        ApiService.shared.callServiceWith(apiName: kDashboardHomeProducts, parameter: jsonRequest, methods:  .post) { (result, error) in
//            if error == nil {
//                let object = result?["Home_Product_Listing"] as? [[String: Any]] ?? []
//                if productListType == .hot {
//                    let hotDeals = object.first!
//                    var aHotProduct: [DashboardProduct] = []
//                    for objecthot in hotDeals["home_data"] as! [[String: Any]] {
//                        aHotProduct.append(DashboardProduct(fromDictionary: objecthot))
//                    }
//                    aDashboardProductSuccess(aHotProduct)
//                }
//                else {
//                    let newCollections = object.last!
//                    var aNewProduct: [DashboardProduct] = []
//                    for objectNew in newCollections["home_data"] as! [[String: Any]] {
//                        aNewProduct.append(DashboardProduct(fromDictionary: objectNew))
//                    }
//                    aDashboardProductSuccess(aNewProduct)
//                }
//            }else {
//                aFailed(error)
//            }
//        }
//    }
    
    
    func getSideMenuCatagorys(
                      aCatagorysSuccess:@escaping  CatagorysSuccess,
                      aFailed:@escaping  Failed){
        ApiService.shared.callServiceWith(apiName: kCategory, parameter: [:], methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["category_data"] as? [[String: Any]] ?? []
                var aCatagorys: [Catagorys] = []
                for objectCatagorys in object {
                    aCatagorys.append(Catagorys(fromDictionary: objectCatagorys))
                }
                UserModel.shared.aSideMenuCatagorys = aCatagorys
                aCatagorysSuccess(aCatagorys)
            }else {
                aFailed(error)
            }
        }
    }
}
