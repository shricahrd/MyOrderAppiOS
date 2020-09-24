//
//  FiltersNewVM.swift
//  MyOrderApp
//
//  Created by Apple on 8/29/20.
//  Copyright © 2020 rakesh. All rights reserved.
//

import UIKit

class FiltersNewVM: NSObject {
    private override init() {}
      static let shared = FiltersNewVM.init()
     var filtersDataResponse = FiltersResponse()
     typealias CompletionHandlerfiltersData = (FiltersResponse?) -> Void
    var arrayListing = Array<FiltersListingData>()
    
    var dictPriceData = PricingData()
    var arrayColorData = Array<ColorData>()
    var arrayCategoryData = Array<CategoryData>()
    var arraySizeData = Array<SizeData>()
    
    //FilterProduct
    var filtersProductResponse = FilterProductResponce()
    var arrayFilterProduct = Array<ProductData>()
    typealias CompletionHandlerFilterProduct = (FilterProductResponce?) -> Void
    func filtersnew(fldbrandid: String,fldcatid: String,fldsearchtxt: String, completion: @escaping CompletionHandlerfiltersData) -> Void {
        let params = [
            "fld_brand_id"  : fldbrandid,
            "fld_cat_id"    : fldcatid,
            "fld_search_txt": fldsearchtxt,
            
        ] as [String: Any]
        print("params orderPlaced: ", params)
//        DIProgressHud.show()
        postMyOrderAPIAction(WebService.filtersnew, parameters:params , showGenricErrorPopup: false) { (response) in
//            DIProgressHud.hide()
            print("filtersnew:", response)
            if let status = response?.value(forKey: "status") as? Int, status == 1 {
                do {
                    let json = try JSONSerialization.data(withJSONObject: response as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
                    let responsefilters = try JSONDecoder().decode(FiltersResponse.self, from: json)
                    self.filtersDataResponse = responsefilters
                    self.arrayListing = self.filtersDataResponse.filter_type_listing ?? [FiltersListingData]()
                    print("self.arrayListing:", self.arrayListing)
//                    self.arrayPriceData = self.arrayListing[0] as? PricingData ?? PricingData()
                    for item in self.arrayListing {
                       print("item:", item)
                        if let title = item.price_data {
                            self.dictPriceData = title
                        }
                        if let title = item.color_data {
                            self.arrayColorData = title
                        }
                        if let title = item.category_data {
                            self.arrayCategoryData = title
                        }
                        if let title = item.size_data {
                           self.arraySizeData = title
                        }
                    }
                    print("self.filtersDataResponse:",  self.dictPriceData)
                    print("self.arrayColorData:", self.arrayColorData)
                    print("self.arrayCategoryData:", self.arrayCategoryData)
                    print("self.arraySizeData:", self.arraySizeData)
                    print("self.filtersDataResponse:", self.filtersDataResponse)
                    print("self.filtersDataResponse:", self.filtersDataResponse)
                    completion(self.filtersDataResponse)
                } catch let error {
                    print(error)
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    
    
    func filtersProduct(parameters:[String: Any], completion: @escaping CompletionHandlerFilterProduct) -> Void {

            print("params orderPlaced: ", parameters)
//            DIProgressHud.show()
            postMyOrderAPIAction(WebService.filterProduct, parameters:parameters , showGenricErrorPopup: false) { (response) in
//                DIProgressHud.hide()
                print("filtersnew:", response)
                if let status = response?.value(forKey: "status") as? Int, status == 1 {
                    do {
                        let json = try JSONSerialization.data(withJSONObject: response as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
                        let responsefilters = try JSONDecoder().decode(FilterProductResponce.self, from: json)
                        self.filtersProductResponse = responsefilters
                        self.arrayFilterProduct = self.filtersProductResponse.product_data ?? [ProductData]()
                        print("self.arrayFilterProduct:", self.arrayFilterProduct)
                        completion(self.filtersProductResponse)
                    } catch let error {
                        print(error)
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }

    
    
    
}
