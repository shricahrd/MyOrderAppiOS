//
//  RewardProductListModel.swift
//  MyOrder
//
//  Created by MAC-51 on 16/12/20.
//

import UIKit
class RewardProductListModel: NSObject {
    var id: Int = 0
    var points: Int = 0
    var qty: Int = 0
    var images: String = ""
    var name: String = ""
    var short_description: String = ""
    var descriptionLocal: String = ""
    var thumbnail: [Thumbnail] = []
    override init(){
    }
    init(fromDictionary dictionary: [String: Any], aThumbnail: [Thumbnail]) {
        self.thumbnail = aThumbnail
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let points = dictionary["points"] as? Int {
            self.points = points
        }
        if let qty = dictionary["qty"] as? Int {
            self.qty = qty
        }
        if let images = dictionary["images"] as? String {
            self.images = images
        }
        if let short_description = dictionary["short_description"] as? String {
            self.short_description = short_description
        }
        if let descriptionLocal = dictionary["description"] as? String {
            self.descriptionLocal = descriptionLocal
        }
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
}
