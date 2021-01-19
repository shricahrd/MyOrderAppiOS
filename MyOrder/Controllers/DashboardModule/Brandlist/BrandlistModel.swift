//
//  BrandlistModel.swift
//  MyOrder
//
//  Created by sourabh on 12/10/20.
//

import UIKit
class BrandlistModel: NSObject {
    var title: String = ""
    var isSelected: Bool = false
    
    init(title: String, selected: Bool = false) {
        self.title = title
        self.isSelected = selected
    }
}
