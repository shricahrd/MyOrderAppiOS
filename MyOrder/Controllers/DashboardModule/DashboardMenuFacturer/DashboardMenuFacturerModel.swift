//
//  DashboardMenuFacturerModel.swift
//  MyOrder
//
//  Created by sourabh on 06/11/20.
//

import UIKit

class DashboardMenuFacturerModel: NSObject {
    var booked_order: Int = 0
    var cart: Int = 0
    var order_dispatched: Int = 0
    var order_received: Int = 0
    override init(){
    }
    init(abooked_order : Int,
         acart: Int,
         aorder_dispatched: Int,
         aorder_received: Int) {
        self.booked_order = abooked_order
        self.cart = acart
        self.order_dispatched = aorder_dispatched
        self.order_received = aorder_received
    }
}
