//
//  LeftMenuModel.swift
//  MyOrder
//
//  Created by gwl on 14/10/20.
//

import UIKit

class LeftMenuModel : NSObject {
    var height: Int = 0
    var isClickable: Bool = false
    var title: String = ""
    var id: Int = 0
    var leftPenalType : LeftPenalType = .none
    init(aTitle: String, aId: Int, aHeight: Int, aClickable: Bool, aLeftPenalType: LeftPenalType) {
        self.title = aTitle
        self.id = aId
        self.height = aHeight
        self.isClickable = aClickable
        self.leftPenalType = aLeftPenalType
    }
}
