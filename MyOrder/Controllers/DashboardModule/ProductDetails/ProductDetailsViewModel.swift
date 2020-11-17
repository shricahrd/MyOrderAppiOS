//
//  ProductDetailsViewModel.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit


typealias ProductDetailSuccess = (_ model: ProductDetailModel) -> Void
typealias DependendSizeSuccess = (_ model: [Sizes]) -> Void


class ProductDetailsViewModel: NSObject {
    func getProductDetails(fld_product_id: Int,
                           fld_color_id: Int,
                           fld_size_id: Int,
                           aProductDetailSuccess:@escaping  ProductDetailSuccess,
                           aFailed:@escaping  Failed) {
        let jsonReq = ["fld_product_id":fld_product_id,
                       "fld_color_id": fld_color_id,
                       "fld_size_id": fld_size_id,
                       "fld_user_id":UserModel.shared.fld_user_id,
        ] as [String : Any]
        
        
        ApiService.shared.callServiceWith(apiName: kProductDetail, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let object = result?["product_detail_data"] as? [String: Any] ?? [:]
                let afld_total_page = result?["fld_total_page"] as? Int ?? 0
                let anext_page = result?["next_page"] as? Int ?? 0
                var sizes: [Sizes] = []
                var color: [Colors] = []
                if let aAttributes = object["attributes"] as? [String: Any] {
                    if let aColors = aAttributes["colors"] as? [[String: Any]] {
                        for subColors in aColors {
                            color.append(Colors(fromDictionary: subColors))
                        }
                    }
                    if let aSizes = aAttributes["sizes"] as? [[String: Any]] {
                        for subSizes in aSizes {
                            sizes.append(Sizes(fromDictionary: subSizes))
                        }
                    }
                }
                let aAttributes = Attributes(aaSizes: sizes, aaColors: color)
                var sellerInfo = SellerInfo()
                if let aInfo = object["fld_seller_info"] as? [String: Any] {
                    sellerInfo = SellerInfo(name: aInfo["fld_supplier_name"] as? String ?? "",
                                            rating: aInfo["fld_seller_rating"] as? Int ?? 0,
                                            policy: aInfo["fld_return_policy_days"] as? String ?? "")
                }
                var thumbnail: [Thumbnail] = []
                if let thumb = object["thumbnail"] as? [[String: Any]] {
                    for subThumb in thumb {
                        thumbnail.append(Thumbnail(aImageUrl: subThumb["image"] as! String))
                    }
                }
                let aProductDetail = ProductDetail(fromDictionary: object, aAttribute: aAttributes, aThumbnail: thumbnail, aFldSellerInfo: sellerInfo)
                let aProductDetailModel = ProductDetailModel(aProductDetail: aProductDetail, afld_total_page: afld_total_page, anextPage: anext_page)
                aProductDetailSuccess(aProductDetailModel)
            }else {
                aFailed(error)
            }
        }
    }
    func getDependendSizeServiceCall(fld_product_id: Int,
                                     fld_color_id: Int,
                                     aDependendSizeSuccess:@escaping  DependendSizeSuccess,
                                     aFailed:@escaping  Failed){
        let jsonReq = ["fld_product_id":fld_product_id,
                       "fld_user_id":UserModel.shared.fld_user_id,
                       "fld_color_id":fld_color_id,
                       "fld_size_id":""] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kGetDependendSize, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let aSizes = result?["sizes_data"] as? [[String: Any]] ?? []
                var sizes: [Sizes] = []
                for subSizes in aSizes {
                    sizes.append(Sizes(fromDictionary: subSizes))
                }
                aDependendSizeSuccess(sizes)
            }else {
                aFailed(error)
            }
        }
    }
}
