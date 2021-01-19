//
//  LedgerListViewModel.swift
//  MyOrder
//
//  Created by sourabh on 31/10/20.
//

import Foundation
import UIKit
typealias LedgerDataSuccess = (_ model: LedgerData) -> Void
class LedgerListViewModel: NSObject {
    func getLedgerServiceCall(ledger_type: Int,
                              afld_date_from: String,
                              afld_date_to: String,
                              aLedger_party_id: Int,
                              azoneassign_panel_type: Int,
                                aLedgerDataSuccess:@escaping  LedgerDataSuccess,
                                aFailed:@escaping  Failed) {
        let jsonReq = ["ledger_party_panel":azoneassign_panel_type,
                       "ledger_type":ledger_type,
                       "ledger_party_id": aLedger_party_id,
                       "fld_date_from": afld_date_from,
                       "fld_date_to": afld_date_to,
                       "fld_user_id": UserModel.shared.fld_user_id,
                       "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kLedger, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
                let partyInfo = result?["party_info"] as? [String: Any] ?? [:]
                var aLedgerSaleData: [LedgerSaleData] = []
                var aLedgerPaymentData: [LedgerPaymentData] = []
                var aLedgerPurchaseData: [LedgerPurchaseData] = []

                let saleData = result?["ledger_sale_data"] as? [[String: Any]] ?? []
                saleData.forEach { sale in
                    aLedgerSaleData.append(LedgerSaleData(fromDictionary: sale))
                }
                let payementData = result?["ledger_payment_data"] as? [[String: Any]] ?? []
                payementData.forEach { pay in
                    aLedgerPaymentData.append(LedgerPaymentData(fromDictionary: pay))
                }
                let purcheshData = result?["ledger_purchase_data"] as? [[String: Any]] ?? []
                purcheshData.forEach { pur in
                    aLedgerPurchaseData.append(LedgerPurchaseData(fromDictionary: pur))
                }
                
                if let json = result as? [String: Any] {
                let dataf =  LedgerData(fromDictionary: json,
                                       aLedgerPartyInfos: LedgerPartyInfo(fromDictionary: partyInfo),
                                       aLedgerSaleDatas: aLedgerSaleData,
                                       aLedgerPurchaseDatas: aLedgerPurchaseData,
                                       aLedgerPaymentDatas: aLedgerPaymentData)
                aLedgerDataSuccess(dataf)
                }
            }else {
                aFailed(error)
            }
        }
    }
}
