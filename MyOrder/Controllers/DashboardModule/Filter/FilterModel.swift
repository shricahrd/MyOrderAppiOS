//
//  FilterModel.swift
//  MyOrder
//
//  Created by gwl on 12/10/20.
//

import UIKit

class FilterModel: NSObject {
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    var id: Int = 0
    var name: String = ""
    var aPricedata = Pricedata()
    var aCategorydata: [Categorydata] = []
    var aBranddata: [Branddata] = []
    var aColordata: [Colordata] = []
    var aSizedata: [Sizedata] = []
    override init(){
    }
    init(aaPricedata: Pricedata,
         aaCategorydata: [Categorydata],
         aaBranddata: [Branddata],
         aaColordata: [Colordata],
         aaSizedata: [Sizedata],
         aName: String,
         aId: Int,
         afld_total_page: Int,
         aNextPage: Int) {
        self.aPricedata = aaPricedata
        self.aCategorydata = aaCategorydata
        self.aBranddata = aaBranddata
        self.aColordata = aaColordata
        self.aSizedata = aaSizedata
        self.name = aName
        self.id = aId
        self.fld_total_page = afld_total_page
        self.nextPage = aNextPage
    }
}
class Pricedata: NSObject {
    var min_price: Int = 0
    var max_price: Int = 0
    var fld_filter_type: String = ""
    var min_price_value: Int = 0
    var max_price_value: Int = 0
    override init(){
    }
    init(aMinPrice: Int, aMaxPrice: Int, aFldFilterType: String) {
        self.min_price = aMinPrice
        self.max_price = aMaxPrice
        self.min_price_value = aMinPrice
        self.max_price_value = aMaxPrice
        self.fld_filter_type = aFldFilterType
    }
}
class Categorydata: NSObject {
    var fld_cat_id: Int = 0
    var fld_cat_name: String = ""
    var isSelected: Bool = false
    override init(){
    }
    init(aCatId: Int, aCatName: String) {
        self.fld_cat_id = aCatId
        self.fld_cat_name = aCatName
    }
}
class Branddata: NSObject {
    var fld_id: Int = 0
    var fld_name: String = ""
    var fld_filter_type: String = ""
    var isSelected: Bool = false
    override init(){
    }
    init(aFidId: Int, aFidName: String, aFldFilterType: String) {
        self.fld_id = aFidId
        self.fld_name = aFidName
        self.fld_filter_type = aFldFilterType
    }
}
class Colordata: NSObject {
    var fld_id: Int = 0
    var fld_name: String = ""
    var fld_code: String = ""
    var fld_filter_type: String = ""
    var isSelected: Bool = false
    override init(){
    }
    init(aFidId: Int, aFidName: String, aFidCode: String, aFldFilterType: String) {
        self.fld_id = aFidId
        self.fld_name = aFidName
        self.fld_code = aFidCode
        self.fld_filter_type = aFldFilterType
    }
}
class Sizedata: NSObject {
    var fld_id: Int = 0
    var fld_name: String = ""
    var fld_filter_type: String = ""
    var isSelected: Bool = false
    override init(){
    }
    init(aFidId: Int, aFidName: String, aFldFilterType: String) {
        self.fld_id = aFidId
        self.fld_name = aFidName
        self.fld_filter_type = aFldFilterType
    }
}
