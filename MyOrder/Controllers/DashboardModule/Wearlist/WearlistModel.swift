//
//  WearlistModel.swift
//  MyOrder
//
//  Created by gwl on 11/10/20.
//

import UIKit

class WearlistModel: NSObject {
    var nextPage: Int = 0
    var fld_total_page: Int = 0
    var aCatagorys: [Catagorys] = []
    init( afld_total_page: Int,
          anextPage: Int,
          aCatagorys: [Catagorys]) {
        self.nextPage = anextPage
        self.fld_total_page = afld_total_page
        self.aCatagorys = aCatagorys
    }
}

class Catagorys: NSObject {
    var id: Int = 0
    var name: String = ""
    var fld_cat_compare: Int = 0
    var image: String = ""
    var banner_image: String = ""
    var fld_app_icon: String = ""
    var isHeading: Bool = true
    var number: Int = 0
    var leftImageName: String = "plus"

    init(fromDictionary dictionary: [String: Any], aNumber: Int = 0, isHeading: Bool = false) {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        if let fld_cat_compare = dictionary["fld_cat_compare"] as? Int {
            self.fld_cat_compare = fld_cat_compare
        }
        if let image = dictionary["image"] as? String {
            self.image = image
        }
        if let banner_image = dictionary["banner_image"] as? String {
            self.banner_image = banner_image
        }
        if let fld_app_icon = dictionary["fld_app_icon"] as? String {
            self.fld_app_icon = fld_app_icon
        }
        self.isHeading = isHeading
        self.number = aNumber
    }
}
