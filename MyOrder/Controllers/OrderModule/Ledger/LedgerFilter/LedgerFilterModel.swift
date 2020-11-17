//
//  LedgerFiterModel.swiftl
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import UIKit


class LedgerList: NSObject {
    var business_name: String = ""
    var id: Int = 0
    override init(){
    }
    init(fromDictionary dictionary: [String: Any]) {
        if let business_name = dictionary["business_name"] as? String {
            self.business_name = business_name
        }
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
    }
}
