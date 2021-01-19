//
//  SearchProductModel.swift
//  MyOrder
//
//  Created by MAC-51 on 06/12/20.
//

import UIKit

class SearchProductModel: NSObject {
    var category_compare: Int = 0
    var category_id: Int = 0
    var category_image: String = ""
    var category_name: String = ""
    var search_name: String = ""
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let category_compare = dictionary["category_compare"] as? Int {
            self.category_compare = category_compare
        }
        if let category_id = dictionary["category_id"] as? Int {
            self.category_id = category_id
        }
        if let category_image = dictionary["category_image"] as? String {
            self.category_image = category_image
        }
        if let category_name = dictionary["category_name"] as? String {
            self.category_name = category_name
        }
        if let search_name = dictionary["search_name"] as? String {
            self.search_name = search_name
        }
    }
}
