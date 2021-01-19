//
//  LeftMenuViewModel.swift
//  MyOrder
//
//  Created by sourabh on 14/10/20.
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
        if UserModel.shared.aSelectedUserType != .manufacture {
            aLeftMenuModel.append(LeftMenuModel(aTitle: "Cart", aId: 105, aHeight: 60, aClickable: true, aLeftPenalType: .cart))
        }
        aLeftMenuModel.append(LeftMenuModel(aTitle: "My Profile", aId: 105, aHeight: 60, aClickable: true, aLeftPenalType: .myProfile))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Invoice", aId: 106, aHeight: 60, aClickable: true, aLeftPenalType: .invoice))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Refer And Earn", aId: 201, aHeight: 60, aClickable: true, aLeftPenalType: .referandearn))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Wallet", aId: 202, aHeight: 60, aClickable: true, aLeftPenalType: .wallet))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Ledger", aId: 107, aHeight: 60, aClickable: true, aLeftPenalType: .ledger))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Issues", aId: 108, aHeight: 60, aClickable: true, aLeftPenalType: .issues))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Reward Products", aId: 203, aHeight: 60, aClickable: true, aLeftPenalType: .reward))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Reward Cart", aId: 205, aHeight: 60, aClickable: true, aLeftPenalType: .rewardCart))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Reward Orders", aId: 204, aHeight: 60, aClickable: true, aLeftPenalType: .redeemOrders))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "About", aId: 109, aHeight: 60, aClickable: true, aLeftPenalType: .about))
        aLeftMenuModel.append(LeftMenuModel(aTitle: "Help & Support", aId: 200, aHeight: 60, aClickable: true, aLeftPenalType: .helpSupport))
        return aLeftMenuModel
    }
}
