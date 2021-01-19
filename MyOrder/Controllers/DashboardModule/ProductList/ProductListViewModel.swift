//
//  ProductListViewModel.swift
//  MyOrder
//
//  Created by sourabh on 11/10/20.
//

import UIKit
typealias ProductListSuccess = (_ model: ProductListModel) -> Void
typealias WishListUpdateSuccess = (_ msg: String) -> Void

class ProductListViewModel: NSObject {
    func getProducts(afld_brand_id: Int,
                     afld_cat_id: Int,
                     afld_search_txt: String,
                     afld_page_no: Int,
                     afld_sort_by: Int,
                     aProductListSuccess:@escaping  ProductListSuccess,
                     aFailed:@escaping  Failed) {
        let jsonReq = ["fld_brand_id":afld_brand_id,
                       "fld_cat_id":afld_cat_id,
                       "fld_user_id":UserModel.shared.fld_user_id,
                       "fld_search_txt":afld_search_txt,
                       "fld_page_no":afld_page_no,
                       "fld_sort_by":afld_sort_by,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kProduct, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["product_data"] as? [[String: Any]] ?? []
                var aProducts: [Product] = []
                for objectProducts in object {
                    aProducts.append(Product(fromDictionary: objectProducts))
                }
                let afld_total_page = result?["fld_total_page"] as? Int ?? 0
                let acart_total_count = result?["cart_total_count"] as? Int ?? 0
                let anext_page = result?["next_page"] as? Int ?? 0
                let agrid_list_view = result?["grid_list_view"] as? Int ?? 0
                
                let aProductList = ProductListModel(aProducts: aProducts,
                                                    afld_total_page: afld_total_page,
                                                    anextPage: anext_page,
                                                    acartTotalCount: acart_total_count,
                                                    aGridListView: agrid_list_view)
                aProductListSuccess(aProductList)
            }else {
                aFailed(error)
            }
        }
    }
    
    func wishlistServiceCall(aProductId: Int,
                             aWishListAdd: Bool,
                             aWishListUpdateSuccess:@escaping  WishListUpdateSuccess,
                             aFailed:@escaping  Failed){
        let jsonReq = ["fld_action_type":aWishListAdd ? 1 : 0,
                       "fld_product_id":aProductId,
                       "fld_user_id":UserModel.shared.fld_user_id,
                       "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kWishListUpdate, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aMessage = result?["message"] as? String ?? ""
                aWishListUpdateSuccess(aMessage)
            }else {
                aFailed(error)
            }
        }
    }
    
    func getFilterProductServiceCall(aFilterModel: FilterModel,
                                     afld_search_txt: String,
                                     afld_sort_by: Int,
                                     afld_page_no: Int,
                                     aCatID: Int,
                                     aProductListSuccess:@escaping  ProductListSuccess,
                                     aFailed:@escaping  Failed) {
        var brandIds: [String] = []
        for brand in aFilterModel.aBranddata {
            if brand.isSelected == true {
                brandIds.append("brand" + brand.fld_id.description)
            }
        }
        var colorIds: [String] = []
        for color in aFilterModel.aColordata {
            if color.isSelected == true {
                colorIds.append("color" + color.fld_id.description)
            }
        }
        var sizeIds: [String] = []
        for size in aFilterModel.aSizedata {
            if size.isSelected == true {
                sizeIds.append("size" + size.fld_id.description)
            }
        }
        var categoryIds: [String] = []
        for cat in aFilterModel.aCategorydata {
            if cat.isSelected == true {
                categoryIds.append(cat.fld_cat_id.description)
            }
        }
//        if aFilterModel.aCategorydata.count <= 0 {
//            categoryIds.append(aCatID.description)
//        }
        
        let jsonReq =  ["fld_cat_id":categoryIds.joined(separator: ","),
                        "fld_scat_id":aCatID.description,
                        "fld_brand_id":brandIds.joined(separator: ","),
                        "fld_size_id":sizeIds.joined(separator: ","),
                        "fld_color_id":colorIds.joined(separator: ","),
                        "fld_max_price":aFilterModel.aPricedata.max_price_value,
                        "fld_min_price":aFilterModel.aPricedata.min_price_value,
                        "fld_page_no":afld_page_no,
                        "fld_sort_by":afld_sort_by,
                        "fld_search_txt":afld_search_txt,
                        "fld_material_id":"",
                        "fld_other_id":"",
                        "fld_user_id":UserModel.shared.fld_user_id,
                        "panel_type":UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kFilterProduct, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["product_data"] as? [[String: Any]] ?? []
                var aProducts: [Product] = []
                for objectProducts in object {
                    aProducts.append(Product(fromDictionary: objectProducts))
                }
                let afld_total_page = result?["fld_total_page"] as? Int ?? 0
                let acart_total_count = result?["cart_total_count"] as? Int ?? 0
                let anext_page = result?["next_page"] as? Int ?? 0
                let agrid_list_view = result?["grid_list_view"] as? Int ?? 0
                
                let aProductList = ProductListModel(aProducts: aProducts,
                                                    afld_total_page: afld_total_page,
                                                    anextPage: anext_page,
                                                    acartTotalCount: acart_total_count,
                                                    aGridListView: agrid_list_view)
                aProductListSuccess(aProductList)
            }else {
                aFailed(error)
            }
        }
    }
    
    func featchHotNewProductsServiceCall(productListType: ProductListType,
                                       afld_page_no: Int,
                                       aDashboardProductSuccess:@escaping  DashboardProductSuccess,
                                       aFailed:@escaping  Failed){
        let jsonRequest = ["fld_product_type": productListType.rawValue,
                           "fld_page_no": afld_page_no,
                           "panel_type": UserModel.shared.aSelectedUserType.rawValue,
                           "fld_user_id": UserModel.shared.fld_user_id
        ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kHomeProduct, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                if productListType == .hot {
                    let hotDeals = result?["hot_deals_data"] as? [[String: Any]] ?? []
                    var aHotProduct: [DashboardProduct] = []
                    for objecthot in hotDeals {
                        aHotProduct.append(DashboardProduct(fromDictionary: objecthot))
                    }
                    aDashboardProductSuccess(aHotProduct)
                }
                else {
                    let newDeals = result?["new_collection_data"] as? [[String: Any]] ?? []
                    var aNewProduct: [DashboardProduct] = []
                    for objecthot in newDeals {
                        aNewProduct.append(DashboardProduct(fromDictionary: objecthot))
                    }
                    aDashboardProductSuccess(aNewProduct)
                }
            }else {
                aFailed(error)
            }
        }
    }
}
