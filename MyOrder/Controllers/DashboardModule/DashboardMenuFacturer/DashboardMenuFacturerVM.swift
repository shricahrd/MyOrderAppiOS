//
//  DashboardMenuFacturerVM.swift
//  MyOrder
//
//  Created by sourabh on 06/11/20.
//

import UIKit

typealias DashboardMenuFacturerSuccess = (_ model: DashboardMenuFacturerModel) -> Void

class DashboardMenuFacturerVM: NSObject{
    func dasshboardServiceCall(aDashboardMenuFacturerSuccess:@escaping  DashboardMenuFacturerSuccess,
                               aFailed:@escaping  Failed){
        let jsonRequest = ["panel_type": UserModel.shared.aSelectedUserType.rawValue,
                           "fld_user_id": UserModel.shared.fld_user_id
        ] as [String : Any]
        ApiService.shared.callServiceWith(apiName: kDashboard, parameter: jsonRequest, methods:  .post) { (result, error) in
            if error == nil {
                let dash = result?["dashboard_data"] as? [String: Any] ?? [:]
                let booked_order = dash["booked_order"] as? Int ?? 0
                let cart = dash["cart"] as? Int ?? 0
                let order_dispatched = dash["order_dispatched"] as? Int ?? 0
                let order_received = dash["order_received"] as? Int ?? 0
                aDashboardMenuFacturerSuccess(DashboardMenuFacturerModel(abooked_order: booked_order, acart: cart, aorder_dispatched: order_dispatched, aorder_received: order_received))
            }else {
                aFailed(error)
            }
        }
    }
}
