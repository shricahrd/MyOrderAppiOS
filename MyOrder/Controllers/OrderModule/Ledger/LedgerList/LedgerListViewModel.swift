//
//  LedgerListViewModel.swift
//  MyOrder
//
//  Created by gwl on 31/10/20.
//

import Foundation
import UIKit
//typealias LedgerListSuccess = (_ model: [LedgerList]) -> Void
class LedgerListViewModel: NSObject {
    func getLedgerServiceCall(afld_date_from: String,
                              afld_date_to: String,
                              aLedger_party_id: Int,
                                aILedgerListSuccess:@escaping  LedgerListSuccess,
                                 aFailed:@escaping  Failed) {
        let jsonReq = ["ledger_party_id": aLedger_party_id,
                       "fld_date_from": afld_date_from,
                       "fld_date_to": afld_date_to,
                       "fld_user_id": UserModel.shared.fld_user_id,
                       "panel_type": UserModel.shared.aSelectedUserType.rawValue] as [String : Any]
        
        ApiService.shared.callServiceWith(apiName: kLedger, parameter: jsonReq, methods:  .post) { (result, error) in
            if error == nil {
//                let object = result?["data"] as? [[String: Any]] ?? []
//                var aIssueList: [IssueList] = []
//                object.forEach { issue in
//                    aIssueList.append(IssueList(fromDictionary: issue))
//                }
//                let invoiceL = IssuesListModel(aIssueList: aIssueList)
//                aIssuesListModelSuccess(invoiceL)
            }else {
                aFailed(error)
            }
        }
    }
}
