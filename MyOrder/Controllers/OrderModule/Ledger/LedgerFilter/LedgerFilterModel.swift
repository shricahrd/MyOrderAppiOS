//
//  LedgerFiterModel.swiftl
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import UIKit


class LedgerList: NSObject {
    var business_name: String = ""
    var id: Int = 0
    var zoneassign_panel_type: Int = 0

    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let business_name = dictionary["business_name"] as? String {
            self.business_name = business_name
        }
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        if let zoneassign_panel_type = dictionary["zoneassign_panel_type"] as? Int {
            self.zoneassign_panel_type = zoneassign_panel_type
        }
        
    }
}
