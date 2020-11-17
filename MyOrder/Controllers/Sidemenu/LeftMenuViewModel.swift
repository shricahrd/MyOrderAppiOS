//
//  LeftMenuViewModel.swift
//  MyOrder
//
//  Created by gwl on 14/10/20.
//

import UIKit

class LeftMenuViewModel: NSObject {
 
    func getSideMenuObjects() -> [LeftMenuModel] {
        var aLeftMenuModel: [LeftMenuModel] = []
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Search by Category", aId: 100, aHeight: 33, aClickable: false, aLeftPenalType: .none))
        let aCatagory = UserModel.shared.aSideMenuCatagorys
        for obj in aCatagory {
            aLeftMenuModel.append(LeftMenuModel(aTitle: obj.name, aId: obj.id, aHeight: 60, aClickable: true, aLeftPenalType: .category))
        }
        aLeftMenuModel.append(LeftMenuModel(aTitle: "", aId: 101, aHeight: 20, aClickable: false, aLeftPenalType: .none))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Dashboard", aId: 102, aHeight: 60, aClickable: true, aLeftPenalType: .dashboard))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "My Orders", aId: 103, aHeight: 60, aClickable: true, aLeftPenalType: .myOrders))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Wishlist", aId: 104, aHeight: 60, aClickable: true, aLeftPenalType: .wishlist))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Cart", aId: 105, aHeight: 60, aClickable: true, aLeftPenalType: .cart))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "My Profile", aId: 105, aHeight: 60, aClickable: true, aLeftPenalType: .myProfile))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Invoice", aId: 106, aHeight: 60, aClickable: true, aLeftPenalType: .invoice))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Ledger", aId: 107, aHeight: 60, aClickable: true, aLeftPenalType: .ledger))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Issues", aId: 108, aHeight: 60, aClickable: true, aLeftPenalType: .issues))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "About", aId: 109, aHeight: 60, aClickable: true, aLeftPenalType: .about))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Help & Support", aId: 200, aHeight: 60, aClickable: true, aLeftPenalType: .helpSupport))
        return aLeftMenuModel
    }
}
